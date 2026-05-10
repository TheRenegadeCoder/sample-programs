section .rodata
usage     db  'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"', 10
usage_len equ $-usage

section    .bss
arr        resd 128 ; Parsed integers are stored here
n          resd 1   ; Number of parsed integers
shared_mem resq 1   ; Pointer to shared mmap() region used as atomic counter

section    .text
global     _start

; ===========================================================================
; Linux x86-64 syscall numbers
; ===========================================================================
%define SYS_write     1
%define SYS_mmap      9
%define SYS_nanosleep 35
%define SYS_fork      57
%define SYS_wait4     61
%define SYS_exit      60

; ===========================================================================
; write_stdout(buffer, length)
;
; Convenience macro for:
;   write(STDOUT_FILENO, buffer, length)
; ===========================================================================
%macro write_stdout 2
    mov eax, SYS_write
    mov edi, 1         ; STDOUT
    mov rsi, %1        ; buffer
    mov rdx, %2        ; length
    syscall
%endmacro

; ===========================================================================
; exit_with(code)
;
; Convenience macro for:
;   exit(code)
; ===========================================================================
%macro exit_with 1
    mov eax, SYS_exit
    mov edi, %1
    syscall
%endmacro

; ===========================================================================
; parse_input
;
; Parses a comma-separated string of signed integers.
;
; INPUT:
;   rdi = pointer to input string
;   rsi = destination integer array
;   rdx = pointer to integer count output
;
; OUTPUT:
;   [rdx] = number of parsed integers
;
; Example:
;   "10, -3, 42"
;
; Produces:
;   arr = {10, -3, 42}
;   n   = 3
;
; NOTES:
; - Spaces are ignored
; - Non-digit garbage is ignored
; - Supports negative integers
; ===========================================================================
parse_input:
    xor r10d, r10d ; Element counter / array index
    xor eax,  eax  ; Current number accumulator
    mov r8d,  1    ; Current sign (+1 or -1)
    xor r9d,  r9d  ; "Currently parsing digits" flag

.next_char:
    movzx ebx, byte [rdi] ; Load next character
    inc   rdi

    ; -----------------------------------------------------------------------
    ; End-of-string check
    ; -----------------------------------------------------------------------
    test bl, bl
    jz   .store_last

    ; -----------------------------------------------------------------------
    ; Comma separator
    ; -----------------------------------------------------------------------
    cmp bl, ','
    je  .store_num

    ; -----------------------------------------------------------------------
    ; Ignore whitespace
    ; -----------------------------------------------------------------------
    cmp bl, ' '
    je  .next_char

    ; -----------------------------------------------------------------------
    ; Handle minus sign
    ; -----------------------------------------------------------------------
    cmp bl, '-'
    jne .is_digit

    mov r8d, -1
    jmp .next_char

; ---------------------------------------------------------------------------
; Digit accumulation
;
; Converts:
;   eax = eax * 10 + digit
;
; Using LEA avoids IMUL.
; ---------------------------------------------------------------------------
.is_digit:
    sub bl, '0'
    jl  .next_char ; Ignore invalid chars below '0'

    cmp bl, 9
    jg  .next_char ; Ignore invalid chars above '9'

    ; eax *= 10
    lea eax, [eax + eax*4] ; eax = eax * 5
    lea eax, [ebx + eax*2] ; eax = eax * 10 + digit

    mov r9d, 1     ; Mark that at least one digit was parsed
    jmp .next_char

; ---------------------------------------------------------------------------
; Store currently accumulated number
; ---------------------------------------------------------------------------
.store_num:
    test r9d, r9d     ; Ignore empty fields like ",,"
    jz   .reset_state

    imul eax, r8d ; Apply sign

    mov [rsi + r10*4], eax ; Store integer into array
    inc r10d

.reset_state:
    xor eax, eax   ; Reset accumulator
    mov r8d, 1     ; Reset sign
    xor r9d, r9d   ; Reset "has digits" flag
    jmp .next_char

; ---------------------------------------------------------------------------
; Store final number at end of string
; ---------------------------------------------------------------------------
.store_last:
    test r9d, r9d
    jz   .exit

    imul eax,           r8d
    mov  [rsi + r10*4], eax
    inc  r10d

.exit:
    mov [rdx], r10d ; Write total element count
    ret

; ===========================================================================
; print_int
;
; Prints signed integer in EAX to stdout.
;
; INPUT:
;   eax = signed integer
; ===========================================================================
print_int:
    push rbp
    mov  rbp, rsp

    ; Local scratch buffer
    sub rsp, 32

    ; Sign-extend to 64-bit for division
    movsxd rax, eax
    mov    r8,  rax ; Preserve original value for sign handling

    ; -----------------------------------------------------------------------
    ; Convert negative values to positive for division loop
    ; -----------------------------------------------------------------------
    test rax, rax
    jns  .init_buffer

    neg rax

.init_buffer:
    ; Build string backwards from the end of the buffer
    lea rdi, [rbp - 1]

    mov ecx, 10 ; Decimal divisor

; ---------------------------------------------------------------------------
; Integer -> ASCII conversion loop
; ---------------------------------------------------------------------------
.convert_loop:
    xor rdx, rdx
    div rcx      ; rax /= 10, remainder -> rdx

    add dl,    '0'
    mov [rdi], dl

    dec rdi

    test rax, rax
    jnz  .convert_loop

; ---------------------------------------------------------------------------
; Add minus sign if original number was negative
; ---------------------------------------------------------------------------
    test r8, r8
    jns  .do_write

    mov byte [rdi], '-'
    dec rdi

.do_write:
    ; RDI currently points one byte before the start of the string
    inc rdi

    mov rsi, rdi

    ; Compute string length
    lea rdx, [rbp - 1]
    sub rdx, rdi
    inc rdx

    ; write(1, buffer, length)
    mov eax, SYS_write
    mov edi, 1
    syscall

    mov rsp, rbp
    pop rbp
    ret

; ===========================================================================
; sleep_sort
;
; Performs "sleep sort" using forked child processes.
;
; INPUT:
;   rsi = pointer to integer array
;   edx = number of elements
; ===========================================================================
sleep_sort:
    push r12
    push r13
    push r14
    push r15

    mov r12,  rsi ; Integer array base pointer
    mov r13d, edx ; Element count

    ; -----------------------------------------------------------------------
    ; Allocate shared memory for atomic completion counter
    ;
    ; fork() creates copy-on-write memory mappings, meaning ordinary .bss
    ; variables are NOT shared after the fork.
    ;
    ; mmap(MAP_SHARED | MAP_ANONYMOUS) creates truly shared writable memory.
    ; -----------------------------------------------------------------------
    mov rax, SYS_mmap

    xor rdi, rdi ; addr = NULL
    mov rsi, 4   ; size = 4 bytes
    mov rdx, 3   ; PROT_READ | PROT_WRITE
    mov r10, 33  ; MAP_SHARED | MAP_ANONYMOUS
    mov r8,  -1  ; fd = -1
    xor r9,  r9  ; offset = 0

    syscall

    mov [shared_mem], rax

    ; completion_counter = 0
    mov dword [rax], 0

; ===========================================================================
; Spawn one child per integer
; ===========================================================================
    xor r14, r14 ; Loop index

.fork_loop:
    cmp r14, r13
    jge .wait_phase

    ; Load integer value for this worker
    mov r15d, [r12 + r14*4]

    ; fork()
    mov rax, SYS_fork
    syscall

    ; Child process returns 0 from fork()
    test rax, rax
    jz   .child_logic

    ; Parent continues spawning children
    inc r14
    jmp .fork_loop

; ===========================================================================
; Child process
; ===========================================================================
.child_logic:

    ; -----------------------------------------------------------------------
    ; Sleep for N seconds
    ;
    ; timespec:
    ;   struct timespec {
    ;       time_t tv_sec;
    ;       long   tv_nsec;
    ;   };
    ; -----------------------------------------------------------------------

    push 0   ; tv_nsec
    push r15 ; tv_sec

    mov rdi, rsp ; &timespec
    xor rsi, rsi ; rem = NULL

    mov rax, SYS_nanosleep
    syscall

    add rsp, 16 ; Remove timespec from stack

    ; -----------------------------------------------------------------------
    ; Local formatting buffer
    ;
    ; Every child constructs its own output string privately.
    ; This prevents multiple processes from corrupting each other's output.
    ; -----------------------------------------------------------------------
    sub rsp, 64

    ; Build string backwards from end of buffer
    lea rdi, [rsp + 63]

    ; -----------------------------------------------------------------------
    ; Atomically increment shared completion counter
    ;
    ; lock inc ensures multiple children cannot race.
    ; -----------------------------------------------------------------------
    mov rbx, [shared_mem]

    lock inc dword [rbx]

    ; Read updated counter value
    mov ecx, [rbx]

    ; -----------------------------------------------------------------------
    ; If not last child, append ", "
    ; -----------------------------------------------------------------------
    cmp ecx, r13d
    je  .convert_num

    dec rdi
    mov byte [rdi], ' '

    dec rdi
    mov byte [rdi], ','

; ---------------------------------------------------------------------------
; Convert integer to ASCII digits
; ---------------------------------------------------------------------------
.convert_num:
    mov eax, r15d
    mov rbx, 10

.loop_div:
    xor rdx, rdx

    div rbx

    add dl, '0'

    dec rdi
    mov [rdi], dl

    test rax, rax
    jnz  .loop_div

; ---------------------------------------------------------------------------
; Atomic output
;
; Because the entire formatted string is emitted in ONE write() syscall,
; Linux guarantees that the bytes from different processes do not interleave.
; ---------------------------------------------------------------------------
    lea rdx, [rsp + 63]
    sub rdx, rdi        ; String length

    mov rsi, rdi ; Buffer pointer
    mov rdi, 1   ; STDOUT

    mov rax, SYS_write
    syscall

    ; Child exits immediately after printing
    exit_with 0

; ===========================================================================
; Parent waits for all children
; ===========================================================================
.wait_phase:
    xor r14, r14

.wait_loop:
    cmp r14, r13
    jge .cleanup

    ; wait4(-1, NULL, 0, NULL)
    ;
    ; Wait for any child process to terminate.
    mov rax, SYS_wait4

    mov rdi, -1

    xor rsi, rsi
    xor rdx, rdx
    xor r10, r10

    syscall

    inc r14
    jmp .wait_loop

.cleanup:
    pop r15
    pop r14
    pop r13
    pop r12
    ret

; ===========================================================================
; ENTRY POINT
; ===========================================================================
_start:

    ; argc
    pop rax

    ; Require at least argv[0] and argv[1]
    cmp rax, 2
    jl  .usage

    ; Skip argv[0]
    pop rsi

    ; argv[1]
    pop rsi

    test rsi, rsi
    jz   .usage

    ; Parse input string
    mov rdi, rsi
    mov rsi, arr
    mov rdx, n

    call parse_input

    ; Require at least 2 integers
    mov eax, [n]

    cmp eax, 2
    jl  .usage

    ; sleep_sort(arr, n)
    mov rsi, arr
    mov edx, eax

    call sleep_sort

    exit_with 0

; ===========================================================================
; Usage message
; ===========================================================================
.usage:
    write_stdout usage, usage_len
    exit_with    1