section .data
    fizz db "Fizz"
    fizz_len equ $-fizz
    buzz db "Buzz"
    buzz_len equ $-buzz
    newline db 10

section .bss
    ; Used to hold the ascii digits for printing
    digits resb 21 

section .text
    global _start

_start:
    mov r12, 1
    mov r13, 101

    loop:
        cmp r12, r13
        je loop_end

        mov rax, r12
        call print_val

        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1
        syscall

        inc r12
        jmp loop

    loop_end:
        mov rax, 60
        xor rdi, rdi
        syscall


; Prints an int. Currently only works for positive values
; rax holds input number
print_num:
    ; push r8
    ; push r9

    lea rcx, [digits] 
    mov r8, 20 ; r8 holds the offset from the digits buffer. We start at the back
    mov r9, 10 ; We will be repeatedly dividing by 10

    div_loop:
        xor rdx, rdx
        div r9
        add rdx, '0'
        mov byte [digits + r8], dl
        dec r8
        cmp rax, 0
        jne div_loop

    inc r8
    mov rax, 1
    mov rdi, 1
    lea rsi, [digits + r8]
    mov rdx, 21
    sub rdx, r8
    syscall

    ; pop r9
    ; pop r8
    ret

    
print_val:
    push r12
    push r13
    xor r12, r12 ; Flag as to whether fizz || buzz was printed
    mov r13, rax ;  Keep a copy of the input to re-use
    
    test_fizz:
        xor rdx, rdx
        mov r8, 3
        div r8
        cmp rdx, 0
        jne test_buzz

        mov rax, 1
        mov rdi, 1
        mov rsi, fizz
        mov rdx, fizz_len
        syscall

        inc r12     

    test_buzz:
        mov rax, r13
        xor rdx, rdx
        mov r8, 5
        div r8
        cmp rdx, 0
        jne test_num

        mov rax, 1
        mov rdi, 1
        mov rsi, buzz
        mov rdx, buzz_len
        syscall

        inc r12 

    test_num:
        cmp r12, 0
        jne cleanup

        mov rax, r13
        call print_num

    cleanup:
        pop r13
        pop r12
        ret