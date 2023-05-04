section .data
    fizz db "Fizz"
    buzz db "Buzz"
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
        call print_num

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

    div_loop_end:
        mov rax, 1
        mov rdi, 1
        lea rsi, [digits + r8]
        mov rdx, 21
        sub rdx, r8
        syscall

        ret

    
; print_val:
    

;     ret