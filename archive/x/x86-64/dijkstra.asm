%DEFINE atol.STACK_INIT 8
%DEFINE atol.ret 8











section .rodata

section .data

struc min_heap:
    .VT
    
    .size resq 1
    .array resq 1
endstruc

struc VT_min_heap:
    
endstruc

struc priority_queue:
    .VT resq 1
    
    .size resq 1
    .heap resq 1

endstruc    

struc VT_priority_queue:
    .construct resq 1
    .destruct resq 1
    
    .push resq 1
    .pop resq 1
    .peek resq 1
    .heapify resq 1
    .isEmpty resq 1
    .size resq 1
    .decreaseKey resq 1   
endstruc

section .bss

section .text

global _start

_start:


parseSRCDST:

parseVertices:

dijkstra:


priority_queue@push:

priority_queue@pop:

priority_queue@peek:

priority_queue@heapify:

priority_queue@isEmpty:

priority_queue@size:

priority_queue@decreaseKey:

priority_queue@construct:

priority_queue@destruct:


minheap@siftUp:

minheap@siftDown:

minheap@swap:

minheap@parent:

minheap@left:

minheap@right:

minheap@construct:

minheap@destruct:

ezsqrt:
; ----------------------------------------------------------------------------
; Function: Easy Square Root
; Description:
;   Checks if number is perfect square; returns square root into RAX.
; Parameters:
;   RDI - (long)          Input value to sqrt.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          RAX == -1 (Input not square); RAX > 0 (Input IS perfect square).
;   Clobbers - RCX
; ---------------------------------------------------------------------------
    PUSH RBP
    MOV RBP, RSP

    MOV RDX, -1
    MOV RCX, 1
    .sqrt_loop:
        MOV RAX, RCX
        MUL RCX
        CMP RAX, RDI
        INC RCX
        CMOVA RAX, RDX
        JB .sqrt_loop
    MOV RAX, RCX
    
    MOV RSP, RBP
    POP RBP
    RET

atoi:
; ----------------------------------------------------------------------------
; Function: atoi
; Description:
;   Converts ascii string to integer.
; Parameters:
;   RDI - (char*)         Pointer to string to convert to integer.
;   RSI - (long)          Strlen.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   EAX - (int)          Integer value of string.
; ---------------------------------------------------------------------------

    PUSH RBP
    MOV RBP, RSP
    SUB RSP, atoi.STACK_INIT
    MOV QWORD [RBP - atoi.ret]
    
    MOV RBX, 10 ;Multiplier
    MOV RCX, 0
    MOV R8B, BYTE [RDI+RCX]
    .operation:
        MOV RAX, QWORD [RBP - atoi.ret]
        MUL RBX
        INC RCX
        SUB R8B, '0'
        ADD RAX, R8
        MOV QWORD [RBP - atoi.ret], RAX
        CMP RCX, RSI ;Compare counter to Strlen
        JNE .operation
    
    MOV RAX, QWORD [RBP - atoi.ret]
    ADD RSP, atoi.STACK_INIT
    MOV RSP, RBP
    POP RBP
    RET
    

