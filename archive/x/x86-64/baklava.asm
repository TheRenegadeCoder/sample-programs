section .data
    star db "*"
    space db " "
    newline db 10

section .text
    global _start

_start:
    mov rax, 1
    push rax
    mov rax, 11
    push rax
    xor rax, rax

outer_loop:
    ; save outer counter
    pop rdx
    push rdx
    cmp rax, rdx
    je newstuff

    push rax

    mov rbx, 10
    sub rbx, rax

space_loop:
    cmp rbx, 0
    je end_space
    push rbx

    ; print space
    mov rax, 1
    mov rdi, 1
    mov rsi, space
    mov rdx, 1
    syscall

    pop rbx
    dec rbx
    jmp space_loop

end_space:
    pop rbx
    push rbx

    shl rbx, 1
    inc rbx

star_loop:
    cmp rbx, 0
    je end_star
    push rbx

    ; print star
    mov rax, 1
    mov rdi, 1
    mov rsi, star
    mov rdx, 1
    syscall

    pop rbx
    dec rbx
    jmp star_loop

end_star:
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
    ; keep looping until target
    jmp outer_loop

newstuff:
    pop rdx
    cmp rdx, -1
    je end

    pop rax
    mov rax, -1
    push rax
    mov rax, -1
    push rax

    mov rax, 9
    jmp outer_loop

end:
    mov rax, 60
    xor rdi, rdi
    syscall