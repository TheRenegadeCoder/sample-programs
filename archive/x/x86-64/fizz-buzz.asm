section .data
    fizz db "Fizz"
    buzz db "Buzz"
    newline db 10

section .text
    global _start

_start:
    mov r12, 1
    