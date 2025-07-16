section .rodata

invalid:
    .msg db 'Usage: please provide three inputs: a serialized matrix, a source node and a destination node'
    .len equ $- .msg


section .data

src_dst:
    .src dq 0
    .dst dq 0
    
minheap:
    .ptr dq 0
    .size dd 0
    .max_size dd 0 ;SYS_MMAP will be based on this value.
section .bss

section .text

global _start

_start:
    
    
    
    
parse_SRC_DST:
; ----------------------------------------------------------------------------
; Function: parse_SRC_DST
; Description:
;   Separated from the vertice parser for organization/readability.
;   Takes ptr to stack source and destination arguments, addressed through argv[2] and argv[3] respectively.
;   Addressing argv[1] will cause an error.
;   Parsed through a finite state machine.
; Parameters:
;   RDI - (char*)         Pointer to stack location of src/dst.
;   RSI - (long*)         Pointer to src/dst storage in .data
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - -1 for invalid input.
; ---------------------------------------------------------------------------    

