section .data
    star db "*"
    space db " "
    newline db 10

section .text
    global _start


; Stack order (top-to-bottom)

; Inner loop counter (inner_i)
; Outer loop counter (outer_i)
; Target (11 or -1)
; Incrementor (+1 or -1)

_start:
    mov rax, 1 ; Incrementor is positive for forward pass
    push rax
    mov rax, 11 ; Target of 11 (exclusive)
    push rax
    xor rax, rax ; Start outer counter at 0

outer_loop:
    pop rdx
    push rdx ; Peek at the target
    cmp rax, rdx
    je end_outer ; Exit the loop if we've met the target

    push rax ; Save outer counter

    mov rbx, 10
    sub rbx, rax ; Pad with 10 - outer_i spaces

    space_loop:
        cmp rbx, 0
        je end_space ; Exit the loop if we've done the required number of loops
        
        push rbx ; Save inner counter

        ; print space
        mov rax, 1
        mov rdi, 1
        mov rsi, space
        mov rdx, 1
        syscall

        pop rbx
        dec rbx 
        jmp space_loop ; Decrement inner counter and keep looping

    end_space:
        pop rbx
        push rbx ; Peek at the outer counter

        shl rbx, 1
        inc rbx ; Loop 2 * outer_i + 1 times

    star_loop:
        cmp rbx, 0
        je end_star ; Exit the loop if we've done the required number of loops
        
        push rbx ; Save inner counter

        ; print star
        mov rax, 1
        mov rdi, 1
        mov rsi, star
        mov rdx, 1
        syscall

        pop rbx
        dec rbx
        jmp star_loop ; Decrement inner counter and keep looping

    end_star:
        ; print newline
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1
        syscall

        
        pop rax ; outer_i
        pop rdx ; target
        pop rdi ; incrementor
        push rdi
        push rdx ; put target and incremenetor back on stack in the same place

        add rax, rdi ; increment in the current direction
        jmp outer_loop ; keep looping

end_outer:
    pop rdx
    cmp rdx, -1
    je end ; If our target is negative, then we've done both passes and can jump to end

    pop rax
    mov rax, -1
    push rax ; Set incrmentor to negative for backwards pass

    mov rax, -1
    push rax ; Set target to -1 for backwards pass

    mov rax, 9
    jmp outer_loop ; Start outer_i at 9. The forward pass handled 10

end:
    ; Exit with return value of 0
    mov rax, 60
    xor rdi, rdi
    syscall