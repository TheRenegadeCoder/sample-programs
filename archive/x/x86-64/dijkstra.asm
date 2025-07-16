section .rodata

invalid:
    .msg db 'Usage: please provide three inputs: a serialized matrix, a source node and a destination node'
    .len equ $- .msg


section .data
    
minheap:
    .ptr dq 0
    .size dd 0
    .max_size dd 0
section .bss

section .text

global _start

_start:

