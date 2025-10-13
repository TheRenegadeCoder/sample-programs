section .rodata

section .data

struc priority_queue:
    .virtualTable resq 1
    .nodes resq 1
    .nodePriorities resq 1
    .size resq 1
    .maxSize resq 1
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


parseSRCDST:

parseVertices:

dijkstra:


priority_queue@insert:

priority_queue@min:

priority_queue@isEmpty:

priority_queue@pop:

priority_queue@decreasePriority:

ezsqrt:

atoi:

    

