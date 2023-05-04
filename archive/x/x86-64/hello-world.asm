section .rodata
    message db 'Hello, World!', 0

section .text
    global _start

_start:
    ; write message to stdout
    mov eax, 1 ; 1 is the system call number for write
    mov edi, 1 ; 1 is the file descriptor for stdout
    mov rsi, message ; address of the message to print
    mov edx, 13 ; number of bytes to print
    syscall ; invoke the system call

    ; exit program with 0
    mov eax, 60 ; 60 is the system call number for exit
    xor edi, edi ; the exit status is stored in edi. Use xor to zero it out
    syscall ; invoke the system call