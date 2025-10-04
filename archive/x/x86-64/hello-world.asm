section .rodata
    message db 'Hello, World!'
    message_len equ $-message

section .text
    global _start

_start:
    ; write message to stdout
    mov rax, 1 ; 1 is the system call number for write
    mov rdi, 1 ; 1 is the file descriptor for stdout
    mov rsi, message ; address of the message to print
    mov rdx, message_len ; number of bytes to print
    syscall ; invoke the system call

    ; exit program with 0
    mov rax, 60 ; 60 is the system call number for exit
    xor rdi, rdi ; the exit status is stored in rdi. Use xor to zero it out
    syscall ; invoke the system call