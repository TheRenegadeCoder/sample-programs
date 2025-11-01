; CONSTANTS
%DEFINE MUL_2 1
%DEFINE DIV_2 1
%DEFINE SIZE_INT 4



%DEFINE atol.STACK_INIT 8
%DEFINE atol.ret 8











section .rodata

section .data

struc min_heap:
    .VT resq 1
    
    .size resq 1
    .array resq 1
endstruc

struc VT_min_heap:
    .construct resq 1
    .destruct resq 1
    
    .siftUp resq 1
    .siftDown resq 1
    .swap resq 1
    .parent resq 1
    .left resq 1
    .right resq 1
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
; ----------------------------------------------------------------------------
; Function: minheap swap
; Description:
;   Swaps elements between given two indices.
; Parameters:
;   RDI - (Minheap*)      This* minheap.
;   ESI - (int)           Index one.
;   EDX - (int)           Index two.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Parent index.
;   Clobbers - None.
; ---------------------------------------------------------------------------
MOV R10, DWORD [RDI+ESI*SIZE_INT] ;TMP
MOV R8, DWORD [RDI+EDX*SIZE_INT] ;TMP2
MOV [RDI+ESI*SIZE_INT], R8D
MOV [RDI+EDX*SIZE_INT], R10D
RET


minheap@parent:
; ----------------------------------------------------------------------------
; Function: minheap parent
; Description:
;   Grabs parent element index relative to given index.
; Parameters:
;   EDI - (int)           Index.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Parent index.
;   Clobbers - None.
; ---------------------------------------------------------------------------
MOV RAX, EDI
DEC RAX
SHR RAX, DIV_2
RET
minheap@left:
; ----------------------------------------------------------------------------
; Function: minheap left
; Description:
;   Grabs left element index relative to given index.
; Parameters:
;   EDI - (int)           Index.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Left element index.
;   Clobbers - None.
; ---------------------------------------------------------------------------
MOV RAX, EDI
SHL RAX, MUL_2
INC RAX
RET
minheap@right:
; ----------------------------------------------------------------------------
; Function: minheap left
; Description:
;   Grabs right element index relative to given index.
; Parameters:
;   EDI - (minheap)           Index.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Right element index.
;   Clobbers - None.
; ---------------------------------------------------------------------------
MOV RAX, EDI
SHL RAX, MUL_2
ADD RAX, 2
RET
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
    

