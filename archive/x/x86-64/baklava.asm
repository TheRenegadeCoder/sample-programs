section .data
    star db "*"
    space db " "
    newline db 10

section .text
    global _start

_start:
    mov rax, 1
    push rax
    mov rax, 10
    push rax
    xor rax, rax

outer_loop:
    ; save outer counter
    push rax

    mov rbx, 10
    sub rbx, rax

space_loop:
    push rbx

    ; print space
    mov rax, 1
    mov rdi, 1
    mov rsi, space
    mov rdx, 1
    syscall

    pop rbx
    dec rbx
    jnz space_loop


    pop rbx
    push rbx

    shl rbx, 1
    inc rbx
star_loop:
    push rbx

    ; print star
    mov rax, 1
    mov rdi, 1
    mov rsi, star
    mov rdx, 1
    syscall

    pop rbx
    dec rbx
    jnz star_loop

    ; print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; get counter
    pop rax
    pop rdx ; target
    pop rdi ; change
    push rdi
    push rdx

    add rax, rdi
    cmp rax, rdx
    ; keep looping until target
    jne outer_loop

newstuff:
    pop rdx
    cmp rdx, 0
    je end

    pop rax
    mov rax, -1
    push rax
    mov rax, 0
    push rax

    mov rax, 8
    jmp outer_loop

end:
    mov rax, 60
    xor rdi, rdi
    syscall

