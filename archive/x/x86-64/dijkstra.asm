; CONSTANTS
%DEFINE MUL_2 1
%DEFINE DIV_2 1
%DEFINE SIZE_INT 4



%DEFINE atol.STACK_INIT 8
%DEFINE atol.ret 8

%DEFINE minheap@siftDown.STACK_INIT 40
%DEFINE minheap@siftDown.minheap_len 8
%DEFINE minheap@siftDown.index 16
%DEFINE minheap@siftDown.left 24
%DEFINE minheap@siftDown.right 32
%DEFINE minheap@siftDown.conditional_BOOLs 40
%DEFINE minheap@siftDown.conditional_BOOLs-1 36
%DEFINE minheap@siftDown.conditional_BOOLs-2 40
%DEFINE minheap@siftDown.conditional_BOOLs-ACCEPT (0x1 + 0x1<<32)

%DEFINE minheap@siftUp.STACK_INIT 16
%DEFINE minheap@siftUp.index 8
%DEFINE minheap@siftUp.parent 16












section .rodata

section .data

struc min_heap:
    .len resq 1
    .array resq 1
    .elements resq 1
endstruc


; I want this priority queue as it acts as a great container for the minheap
; and allows for easy abstraction of minheap methods.
struc priority_queue:
    .size resq 1
    .heap resq 1
endstruc    

section .bss

section .text

global _start

_start:


parseSRCDST:

parseVertices:

dijkstra:


priority_queue@push:
; ----------------------------------------------------------------------------
; Function: priority queue push.
; Description:
;   Pushes new value into minheap.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   ESI - (value)         Value to insert.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - RDI, RSI, RDX, R10, R8.
; ---------------------------------------------------------------------------
MOV RDX, [RDI + priority_queue.heap]
MOV R10, [RDX + minheap.array]
MOV R8, [RDX + minheap.len]

MOV [R10 + R8*SIZE_INT], ESI
INC [RDX + minheap.len]
DEC R8
MOV RDI, RDX
MOV ESI, R8
CALL minheap@siftUp
RET

priority_queue@pop:

priority_queue@peek:

priority_queue@heapify:

priority_queue@isEmpty:

priority_queue@size:

priority_queue@decreaseKey:

priority_queue@construct:

priority_queue@destruct:


minheap@siftUp:
; ----------------------------------------------------------------------------
; Function: minheap swap
; Description:
;   Restores min-heap by moving new element upward.
; Parameters:
;   RDI - (Minheap*)      This* minheap. Will not juggle this; stays in callee-saved register.
;   ESI - (int)           Index.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - RDI, RSI, RDX, R10, R8.
; ---------------------------------------------------------------------------
PUSH RBP
MOV RBP, RSP
SUB RSP, minheap@siftUp.STACK_INIT
PUSH RBX
MOV RBX, RDI
MOV [RBP - minheap@siftUp.index], RSI
    .sift:
        CMP [RBP - minheap@siftUp.index], 0
        JBE .sift_end
        MOV RDI, [RBP - minheap@siftUp.index]
        CALL minheap@parent
        MOV RDX, [RBP - minheap@siftUp.index]
        MOV R10, RAX
        MOV R8, RBX
        MOV R9, RBX
        MOV R8, [R8 + minheap.array]
        MOV RDX, [R8 + RDX*SIZE_INT]
        MOV R10, [R8 + RDX*SIZE_INT]
        CMP RDX, R10
        JAE .sift_end
        MOV RDI, RBX
        MOV RDI, [RBX + minheap.array]
        MOV RSI, [RBP - minheap@siftUp.index]
        MOV RDX, RAX
        CALL minheap@swap
        MOV RDI, RBX
        MOV RDI, [RDI + minheap.array]
        CALL minheap@swap
        MOV [RBP - minheap@siftUp.index], RAX
        JMP .sift
.sift_end:
POP RBX
ADD RSP, minheap@siftUp.STACK_INIT
MOV RSP, RBP
POP RBP
RET
minheap@siftDown:
; ----------------------------------------------------------------------------
; Function: minheap swap
; Description:
;   Restores min-heap by moving root downward.
; Parameters:
;   RDI - (Minheap*)      This* minheap. Will not juggle this; stays in callee-saved register.
;   ESI - (int)           Index.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()          None.
;   Clobbers - RAX, RDI, RSI, RCX, RDX, R9.
; ---------------------------------------------------------------------------
PUSH RBP
MOV RBP, RSP
SUB RSP, minheap@siftDown.STACK_INIT
PUSH RBX ; Minheap*
PUSH R11
PUSH R12

MOV RBX, RDI
MOV RDI, [RBX + min_heap.len]
MOV [RBP - minheap@siftDown.minheap_len], RDI
MOV [RBP - minheap@siftDown.index], RSI

    .sift:
        MOV RDI, [RBP - minheap@siftDown.index]
        CALL minheap@left
        PUSH RAX
        CMP RAX, [RBP - minheap@siftDown.minheap_len]
        JA .sift_exit
        
        POP RAX
        MOV RCX, RAX ; Left
        MOV [RBP - minheap@siftDown.left], RAX
        CALL minheap@right
        MOV RDX, RAX ; Right
        MOV [RBP - minheap@siftDown.right], RAX
        MOV R9, RCX
        CMP RDX, [RBP - minheap@siftDown.minheap_len]
        SETB [RBP - minheap@siftDown.conditional_BOOLs-1]
        MOV RAX, [RBX + minheap.array]
        MOV RCX, [RAX + RCX*SIZE_INT]
        MOV RDX, [RAX + RCX*SIZE_INT]
        CMP RDX, RCX
        SETB [RBP - minheap@siftDown.conditional_BOOLs-2]
        CMP [RBP - minheap@siftDown.conditional_BOOLs-1], minheap@siftDown.conditional_BOOLs-ACCEPT
        CMOVB R9, [RBP - minheap@siftDown.right]
        
        MOV RAX, [RBX + minheap.array]
        MOV R11, R9
        MOV R11, [RAX + R11*SIZE_INT]
        MOV R12, [RBP - minheap@siftDown.index]
        MOV R12, [RAX + R12*SIZE_INT]
        CMP R11, R12
        JAE .sift_exit
        MOV RDI, RBX
        MOV RDI, [RDI + minheap.array]
        MOV RSI, [RBP - minheap@siftDown.index]
        MOV RDX, R9
        CALL minheap@swap
        MOV RDI, RBX
        MOV RDI, [RDI + minheap.elements]
        CALL minheap@swap
        MOV [RBX - minheap@siftDown.index], R9
        
        JMP .sift
                             
.sift_exit:
POP R12
POP R11
POP RBX
ADD RSP, minheap@siftDown.STACK_INIT  
MOV RSP, RBP
POP RBP
RET 
    
    
minheap@swap:
; ----------------------------------------------------------------------------
; Function: minheap swap
; Description:
;   Swaps elements between given two indices.
; Parameters:
;   RDI - (int[]*)        Minheap array to operate on.
;   ESI - (int)           Index one.
;   EDX - (int)           Index two.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - RDI, R8, R10
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
;   Clobbers - RAX
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
;   Clobbers - RAX
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
;   Clobbers - RAX
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
;   Clobbers - RAX, RDI, RCX, RDX
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
;   Clobbers - RAX, RDI, RSI, RCX, R8. 
; ---------------------------------------------------------------------------

    PUSH RBP
    MOV RBP, RSP
    SUB RSP, atoi.STACK_INIT
    PUSH RBX
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
    POP RBX
    ADD RSP, atoi.STACK_INIT
    MOV RSP, RBP
    POP RBP
    RET
    

