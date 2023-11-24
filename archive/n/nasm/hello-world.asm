; ------------------------------------------------------------------
; hello-world.asm
;
; This is a console program that writes "Hello, World!"
; on a single line and then exits.
;
; To assemble: nasm -f elf64 -o hello-world.o hello-world.asm
; To compile:  gcc -o hello-world hello-world.o
; To run: ./hello-world
; ------------------------------------------------------------------

; Source: https://www.mourtada.se/calling-printf-from-the-c-standard-library-in-assembly/

        ; code is put in the .text section
        section   .text
        default   rel
        global    main                 ; declare main() method
        extern    printf               ; link to external library

main:                             ; the entry point! void main()
        push    rbp               ; create stack frame
        mov     rdi, fmt          ; set format string
        mov     rsi, message      ; set message string
        mov	rax, 0            ; not sure why this is needed
        call    printf wrt ..plt  ; call printf
        pop     rbp               ; destroy stack frame
        mov     rax, 0            ; set return code
        ret                       ; return

        segment   .data
        default   rel
        fmt:      db   '%s', 0                  ; format string
        message:  db   'Hello, World!', 0xA, 0  ; text message
                       ; 0xA (10) is hex for (NL), carriage return
                       ; 0 terminates the line
