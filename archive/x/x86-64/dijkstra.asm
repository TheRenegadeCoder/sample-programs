section .rodata

section .data

struc priority_queue:
    .virtualTable
    .nodes
    .nodePriorities
    .size
    .maxSize
endstruc

struc VT_priority_queue:
    .insert resq 1
    .min resq 1
    .isEmpty resq 1
    .pop resq 1
    .decreasePriority resq 1
endstruc

section .bss

section .text

global _start

_start:


dijkstra:


priority_queue@insert:

priority_queue@min:

priority_queue@isEmpty:

priority_queue@pop:

priority_queue@decreasePriority:

    

