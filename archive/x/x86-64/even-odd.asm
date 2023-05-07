section .data
    error_msg db "Usage: please input a number"
    error_len equ $-error_msg
    even_msg db "Even"
    even_len equ $-even_msg
    odd_msg db "Odd"
    odd_len equ $-odd_msg

section .bss
    input resb 1

section .text
    global _start

_start:
    xor r12, r12 ; r12 will hold whether we've looked at at least one byte
    read_loop:
        mov rax, 0
        mov rdi, 0
        mov rsi, input
        mov rdx, 1
        syscall

        ; Finish loop when reading reads 0 bytes or encountering a newline
        cmp rax, 0
        je end_loop
        mov rax, [input]
        cmp rax, 10
        je end_loop

        mov rbx, [input]
        cmp bl, "-"
        jne non_minus

        minus_sign:
            ; If we've already read at least one character, reading a minus is invalid
            cmp r12, 0
            jne error

            jmp valid_char

        non_minus:
            ; If it's not a minus sign and has an ascii value not in the range '0'-'9', it's invalid
            cmp bl, '0'
            jl error
            cmp bl, '9'
            jg error

        valid_char:
            mov r12, 1 ; Mark that at least one byte has been read
            jmp read_loop

    end_loop:
        ; If we didn't read at least one character, there is an error
        cmp r12, 0
        je error

        ; If the only character we read is '-', there is an error
        cmp bl, '-'
        je error

        ; Check whether the last bit of the last char inputted is 1
        ; Because even ASCII digits have even ascii codes we don't need to convert it to the number first
        and rbx, 1
        cmp rbx, 0
        jne odd

        even:
            ; Print 'Even'
            mov rax, 1
            mov rdi, 1
            mov rsi, even_msg
            mov rdx, even_len
            syscall
            jmp cleanup

        odd:
            ; Print 'Odd'
            mov rax, 1
            mov rdi, 1
            mov rsi, odd_msg
            mov rdx, odd_len
            syscall
            jmp cleanup



    error:
        ; Print error message
        mov rax, 1
        mov rdi, 1
        mov rsi, error_msg
        mov rdx, error_len
        syscall

    cleanup:
        ; Exit with return value 0
        mov rax, 60
        xor rdi, rdi
        syscall