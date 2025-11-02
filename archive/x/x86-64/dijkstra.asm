;Exit codes
%DEFINE EXIT_OK 0

%DEFINE INVALID_ARGC 1
%DEFINE INVALID_SRC/DST 2
%DEFINE INVALID_NUM_NEG 3
%DEFINE INVALID_CHAR 4
%DEFINE INVALID_NUM_VERTS 5
%DEFINE INVALID_NOT_SQUARE 6
%DEFINE INVALID_STATE 7
%DEFINE INVALID_EMPTY 8
%DEFINE INVALID_BAD_STR 9

; CONSTANTS
%DEFINE MUL_2 1
%DEFINE MUL_4 2
%DEFINE DIV_2 1
%DEFINE SIZE_INT 4
%DEFINE SIZE_LONG 8
%DEFINE EMPTY_INPUT 0
%DEFINE INF 0xFFFFFFFF
%DEFINE NULL 0
%DEFINE FALSE 0
%DEFINE TRUE 1
%DEFINE MAX_STR_INT 11 ; 10 (Max Int) + 1 (Null)

%DEFINE COMMA_SPACE 2



; Functions/Methods

%DEFINE atoi.STACK_INIT 8
%DEFINE atoi.ret 8

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

%DEFINE priority_queue@construct.STACK_INIT 8
%DEFINE priority_queue@construct.PQPtr 8

%DEFINE parseSRCDST.STACK_INIT 8
%DEFINE parseSRCDST.strlen 8

%DEFINE parseVertices.STACK_INIT 48
%DEFINE parseVertices.strlen 8
%DEFINE parseVertices.SRC 16
%DEFINE parseVertices.DST 24
%DEFINE parseVertices.NumPtr 32
%DEFINE parseVertices.PrevState 40
%DEFINE parseVertices.NumElems 48


;SYSCALLS
;STDIN/OUT
%DEFINE SYS_WRITE 1
%DEFINE STDOUT 1
;Memory
%DEFINE SYS_MMAP 9
%DEFINE NO_ADDR 0
%DEFINE NO_FD -1
%DEFINE NO_OFFSET 0
;PROTS (RDX)
%DEFINE PROT_READ 0x01
%DEFINE PROT_WRITE 0x02
;FLAGS (R10)
%DEFINE MAP_SHARED 0x01
%DEFINE MAP_ANONYMOUS 0x20

%DEFINE SYS_MUNMAP 11

;Thread
%DEFINE SYS_EXIT 60



;Start

%DEFINE _start.argc 8
%DEFINE _start.argv0 16
%DEFINE _start.argv1 24
%DEFINE _start.argv2 32
%DEFINE _start.argv3 40
; RBP+ ^
; RBP- v
%DEFINE _start.STACK_INIT 40
%DEFINE _start.SRC 8
%DEFINE _start.DST 16
%DEFINE _start.NumVerts 24
%DEFINE _start.graph 32
%DEFINE _start.RET 40

%DEFINE dijkstra.STACK_INIT 64
%DEFINE dijkstra.PriorityQueue 8
%DEFINE dijkstra.NumVerts 16
%DEFINE dijkstra.prev 24
%DEFINE dijkstra.dist 32
%DEFINE dijkstra.SRC 40
%DEFINE dijkstra.DST 48
%DEFINE dijkstra.graph 56
%DEFINE dijkstra.CurrTex 64





section .rodata

Error:
    .msg db 'Usage: please provide three inputs: a serialized matrix, a source node and a destination node'
    .len equ $- .msg
    
Err_Table: ; This is absurd but this because of CMOV not allowing immediates.
    db 0
    db -1
    db -2
    db -3
    db -4
    db -5
    db -6
    db -7
    db -8
    db -9
    

section .data

Error_state:
    .CODE db 0

struc min_heap:
    .arr_size resq 1
    .len resq 1
    .array resq 1
    .elements resq 1
endstruc

struc NodeTuple:
    .value resd 1
    .element resd 1
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
MOV RBP, RSP
PUSH RBP
SUB RSP, _start.STACK_INIT

MOV RAX, [RBP + _start.argv1]
MOV RCX, 0
.count_commas:
    CMP BYTE [RAX + RCX], 0
    JE .count_end
    CMP BYTE [RAX + RCX], ','
    SETE BL
    MOVZX RBX, BL
    ADD RCX, RBX
    MOV RBX, 0
.count_end:    
MOV RDI, RCX
CALL ezsqrt
CMP RAX, -1
CMOVE RDI, [Err_Table + INVALID_NOT_SQUARE]
JE .error
MOV [RSP - _start.NumVerts], RAX

MOV RDI, [RBP + _start.argv2]
CALL parseSRCDST
MOV [RBP + _start.SRC], RAX

MOV RDI, [RBP + _start.argv3]
CALL parseSRCDST
MOV [RBP + _start.DST], RAX

MOV RAX, [RBP - _start.NumVerts]
MUL RAX

PUSH RAX
MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
POP RSI
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - _start.graph], RAX

MOV RDI, [RBP + _start.argv1]
MOV RSI, [RBP - _start.graph]
CALL parseVertices

MOV RDI, [RBP - _start.SRC]
MOV RSI, [RBP - _start.DST]
MOV RDX, [RBP - _start.graph]
MOV R10, [RBP - _start.NumVerts]
CALL dijkstra

MOV RCX, [RBP - _start.DST]
MOV RBX, [RAX + RCX*SIZE_INT]
MOV [RBP - _start.RET], RBX

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, MAX_STR_INT
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL

PUSH RAX
MOV RDI, RBX
MOV RSI, RAX
CALL iota
MOV RAX, R10

MOV RAX, SYS_WRITE
MOV RDI, STDOUT
POP RSI
MOV RDX, R10
SYSCALL

MOV RAX, SYS_EXIT
MOV RDI, [Err_Table+EXIT_OK]
SYSCALL


.error:
    PUSH RDI
    MOV RAX, SYS_WRITE
    MOV RDI, STDOUT
    MOV RSI, Error.msg
    MOV RDX, Error.len
    SYSCALL
    
    MOV RAX, SYS_EXIT
    POP RDI
    SYSCALL

itoa:
; ----------------------------------------------------------------------------
; Function: Int to ASCII
; Description:
;   Converts integer to ASCII, returned through char[] ptr.
; Parameters:
;   RDI - (int)           Int to convert.
;   RSI - (char[]*)       String ptr.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (int)           Strlen.    
;   Clobbers - RAX, RDI, RSI, RCX, RDX
; ---------------------------------------------------------------------------
PUSH RBX
PUSH RDX
PUSH R10
PUSH R8
MOV RCX, 0
MOV RAX, RDI
MOV RBX, 10
    .loop:
        CMP RDI, 0
        JE .ext
        DIV RBX
        ADD RDX, '0'
        MOV BYTE [RSI + RCX], DL
        INC RCX
        JMP .loop
.ext:
MOV BYTE [RSI + RCX], 0
PUSH RCX
DEC RCX
MOV RDX, 0
    .reverse:
        CMP RDX, RCX
        JAE .ext2
        MOV R10B, [RSI+RDX]
        MOV R8B, [RSI+RCX]
        MOV [RSI+RDX], R8B
        MOV [RSI+RDX], R10B
        INC RDX
        DEC RCX
        JMP .reverse
.ext2:
POP RCX
MOV RAX, RCX
POP R8
POP R10
POP RDX
POP RBX
RET

parseSRCDST:
; ----------------------------------------------------------------------------
; Function: Parse SRC & DST.
; Description:
;   Parses given SRC OR DST. Separated from vertice parser for modularity and organization.
;   Parsed through Finite State Machine.
; Parameters:
;   RDI - (char[]*)       Ptr to SRC/DST char array.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   EAX - (int)           SRC/DST
;   Clobbers - RAX, RDI, RSI, RCX, RDX
; ---------------------------------------------------------------------------
MOV RBP, RSP
PUSH RBP
SUB RSP, parseSRCDST.STACK_INIT

MOV RCX, 0
    .validate:
    MOV DL, BYTE [RDI]
    JMP [.jmpTable + RDX*SIZE_LONG]
    .jmpTable:
        dq .zero
        times 48 dq .error
        times 10 dq .num
        times 197 dq .error
    .cont:
        MOV RSI, RCX
        CALL atoi
        MOVZX RAX, EAX
        ADD RSP, parseSRCDST.STACK_INIT
        MOV RSP, RBP
        POP RBP
        RET
    .zero:
        CMP RCX, 0
        CMOVE RAX, [Err_Table+INVALID_SRC/DST]
        JE .error
        JNE .cont
    .num:
        INC RCX
        JMP .validate
    .error:
        PUSH RAX
        MOV RAX, SYS_WRITE
        MOV RDI, STDIN
        MOV RSI, Error.msg
        MOV RDX, Error.len
        SYSCALL
        
        MOV RAX, SYS_EXIT
        POP RDI
        SYSCALL

parseVertices:
; ----------------------------------------------------------------------------
; Function: Parse Vertices.
; Description:
;   Parses given vertices from array and checks for errors.
;   Parsed through Finite State Machine.
; Parameters:
;   RDI - (char[]*)       Ptr to vertice char array.
;   RSI - (int[][]*)      Ptr to distances 2d array.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (int)           Num elements (RAX > 0)
;   Clobbers - RAX, RDI, RSI, RCX, RDX.
; ---------------------------------------------------------------------------
;Previous States
    %DEFINE Parse.STATE.START 0000b
    %DEFINE Parse.STATE.NUM 0001b
    %DEFINE Parse.STATE.COMMA 0010b
    %DEFINE Parse.STATE.SPACE 0100b
    %DEFINE Parse.STATE.ZERO 1000b
MOV RBP, RSP
PUSH RBP
SUB RSP, parseVertices.STACK_INIT

MOV [RBP - parseVertices.SRC], RDI
MOV [RBP - parseVertices.DST], RSI
MOV [RBP - parseVertices.NumElems], 0

MOV AL, BYTE [RDI]
CMP AL, EMPTY_INPUT
CMOVE RAX, [Err_Table+INVALID_EMPTY]
JE .error

MOV RCX, 0
MOV [RBP - parseVertices.NumPtr], RDI
    .validate:
    MOV DL, BYTE [RDI+RCX]
    JMP [.jmpTable + RDX*SIZE_LONG]
    .jmpTable:
        dq .zero
        times 31 dq .error
        dq .space
        times 11 .error
        dq .comma
        times 3 dq .error
        times 10 dq .num
        times 197 dq .error
    
    .num:
        CMP [RBP - parseVertices.PrevState], Parse.STATE.START
        JE .errSkip
        PUSH RDI
        PUSH RAX
        MOV RAX, [RBP - parseVertices.NumPtr]
        MOV RAX, [RAX]
        ADD RDI, RCX
        CMP [RBP - parseVertices.PrevState], Parse.STATE.SPACE
        CMOVE RAX, RDI
        MOV [RBP - parseVertices.NumPtr], RAX
        POP RAX
        POP RDI
        JE .errSkip
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR]
        JMP .error
        .errSkip: 
        INC [RBP - parseVertices.strlen]
        INC RCX
        MOV [RBP - parseVertices.PrevState], Parse.STATE.NUM
        JMP .validate
        
    .comma:
        CMP [RBP - parseVertices.PrevState], Parse.STATE.NUM
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR]
        JNE .error
        
        .zero_jmp:
        PUSH RAX
        PUSH RDI
        PUSH RSI
        PUSH RCX
        PUSH RDX
        MOV RDI, [RBP - parseVertices.NumPtr]
        MOV RSI, [RBP - parseVertices.strlen]
        CALL atoi
        MOV RDI, [RBP - parseVertices.DST]
        MOV RCX, [RBP - parseVertices.NumElems]
        MOV [RDI + RCX*SIZE_INT], EAX
        POP RDX
        POP RCX
        POP RSI
        POP RDI
        POP RAX
        CMP [RBP - parseVertices.PrevState], PARSE.STATE.ZERO
        JE .zero_cont
        
        MOV [RBP - parseVertices.PrevState], PARSE.STATE.COMMA
        MOV [RBP - parseVertices.strlen], 0
        INC RCX
        INC [RBP - parseVertices.NumElems]
        JMP .validate     
    .space:
        CMP [RBP - parseVertices.PrevState], Parse.STATE.COMMA
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR]
        JNE .error
        
        JMP .validate
    .zero:
        CMP [RBP - parseVertices.PrevState], Parse.STATE.NUM
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR]
        JNE .error       
        CMP RCX, 0
        CMOVE RDI, [Err_Table+INVALID_BAD_STR]
        JE .error
        MOV [RBP - parseVertices.PrevState], Parse.STATE.ZERO
        JMP .zero_jmp ; I don't like this backwards GOTO.
        .zero_cont:
        JMP .cont
        
    .cont:
        MOV RAX, [RBP - parseVertices.NumElemes]
    
        ADD RSP, parseVertices.STACK_INIT
        MOV RSP, RBP
        POP RBP
        RET
    .error:
        PUSH RDI
        MOV RAX, SYS_WRITE
        MOV RDI, STDIN
        MOV RSI, Error.msg
        MOV RDX, Error.len
        SYSCALL
        
        ;For debugging, I can also add pointers, or other info into other registers before SYSCALLing.
        MOV RAX, SYS_EXIT
        POP RDI
        SYSCALL
        
        
        
        
        

dijkstra:
; ----------------------------------------------------------------------------
; Function: priority queue push.
; Description:
;   The algorithm of study itself, Dijkstra.
; Parameters:
;   RDI - (int)           SRC.
;   RSI - (int)           DST.
;   RDX - (int[][]*)      Graph to vertice&edges.
;   R10 - (int)           # Vertices.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (int[]*)        Array of distances.
;   Clobbers - RAX, RSI, RDX, R10, R8, R9.
; ---------------------------------------------------------------------------
MOV RBP, RSP
PUSH RBP
SUB RSP, dijkstra.STACK_INIT
PUSH RBX
PUSH R11
PUSH R12
PUSH R13

MOV [RBP - dijkstra.SRC], RDI
MOV [RBP - dijkstra.DST], RSI
MOV [RBP - dijkstra.graph], RDX
MOV [RBP - dijkstra.NumVerts], R10

MOV [RBP - dijkstra.CurrTex], RDI

MOV RDI, R10
CALL priority_queue@construct
MOV [RBP - dijkstra.priority_queue], RAX

PUSH R10
PUSH R10

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
POP RSI
SHL RSI, MUL_4
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - dijkstra.dist], RAX
MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
POP RSI
SHL RSI, MUL_4
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - dijkstra.prev], RAX

MOV RDI, [RBP - dijkstra.dist]
MOV RSI, [RBP - dijkstra.CurrTex]
MOV DWORD [RDI + RSI], 0

MOV RDI, RSI
MOV RSI, 0
CALL dijkstra~GenerateTuple

MOV RDI, [RBP - dijkstra.PriorityQueue]
MOV RSI, RAX
CALL priority_queue@push

MOV RCX, 0
MOV RDI, [RBP - dijkstra.dist]
MOV RSI, [RBP - dijkstra.prev]
MOV RDX, [RBP - dijkstra.PriorityQueue]
    .add_vertex_loop:
        CMP RCX, [RBP - dijkstra.NumVerts]
        JAE .v_loop_exit
        CMP RCX, [RBP - dijkstra.SRC]
        JE .vtx_loop_cont
        
        MOV [RDI+RCX*SIZE_INT], INF
        MOV [RSI+RCX*SIZE_INT], -1
        
        PUSH RDI
        PUSH RSI
        PUSH RCX
        PUSH RDX
        
        MOV RDI, -1
        MOV RSI, INF
        CALL dijkstra~GenerateTuple
        MOV RDI, [RBP - dijkstra.PriorityQueue]
        MOV RSI, RAX
        CALL priority_queue@push
        
        POP RDX
        POP RCX
        POP RSI
        POP RDI
        .vtx_loop_cont: ; Fall through ^
        INC RCX
        JMP .add_vertex_loop
        
        
.v_loop_exit: 
MOV R13, [RBP- dijkstra.PriorityQueue]
MOV RBX, [RBP - dijkstra.dist]
    .dijkstra_loop:
        MOV RDI, R13
        CALL priority_queue@isEmpty
        MOV R11, RAX
        CMP R11, TRUE
        JE .dijkstra_exit
        
        MOV RDI, R13
        CALL priority_queue@pop
        MOV R12, RAX
        MOVZX EDI, DWORD [R12 + NodeTuple.value]
        MOV [RBP - dijkstra.CurrTex], RDI
        MOV RCX, 0
        .dijkstra_get_neighbors:
            MOV R8, [RBP - dijkstra.CurrTex]
            MOV RAX, R8
            MOV R9, [RBP - dijkstra.NumVerts]
            MUL R9
            
            MOV R10, [RBP - dijkstra.graph]
            ADD R10, RAX
            .neighbors_loop:
                CMP [R10 + RCX*SIZE_INT], NULL
                JNE .neighbor_cont
                INC RCX
                JMP .neighbors_loop
            .neighbor_cont:
                MOV RSI, RBX
                MOV RSI, [RSI + R8*SIZE_INT]
                ADD RSI, [R10 + RCX*SIZE_INT]
                CMP RSI, [RBX + RCX*SIZE_INT]
                JAE .neighbors_loop
                PUSH RSI
                MOV [RBX + RCX*SIZE_INT], RSI
                MOVZX EDI, [R12 + NodeTuple.element]
                PUSH RDI
                MOV RSI, [RBP - dijkstra.prev]
                MOV [RSI + RCX*SIZE_INT], EDI
                MOV RDI, R13
                POP RSI
                POP RDX
                PUSH R10
                PUSH RCX
                
                CALL priority_queue@decreaseKey
                POP RCX
                POP R10
                INC RCX
                CMP RCX, [RBP - dijkstra.NumVerts]
                JAE .dijkstra_loop
                JB .neighbors_loop
        
MOV RAX, [RBP - dijkstra.dist]
ADD RSP, dijkstra.STACK_INIT
MOV RSP, RBP
POP RBP
RET


dijkstra~GenerateTuple:
; ----------------------------------------------------------------------------
; Function: Dijkstra Generate Tuple
; Description:
;   Helper method for dijkstra to generate tuples.
;   Preserving RDX, R10, R8, R9 as I know it will be annoying restoring those for every call if clobbered.
;   Can replace ad hoc instances of tuple generation.
; Parameters:
;   RDI - (int)           Element.
;   RSI - (int)           Value.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (NodeTuple*)    Generated Tuple.
;   Clobbers - RAX, RDI, RSI.
; ---------------------------------------------------------------------------
PUSH RDX
PUSH R10
PUSH R8
PUSH R9
MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, NodeTuple_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RAX + NodeTuple.value], EDX
MOV [RAX + NodeTuple.element], ESI
POP R9
POP R8
POP R10
POP RDX
RET


priority_queue@push:
; ----------------------------------------------------------------------------
; Function: priority queue push.
; Description:
;   Pushes new value into minheap.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - (NodeTuple*)    Tuple that contains distance and element.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - RDI, RSI, RCX, RDX, R10, R8, R9.
; ---------------------------------------------------------------------------
MOV EDX, [ESI + NodeTuple.element]
MOV ESI, [ESI + NodeTuple.value]
MOV R10, [RDI + priority_queue.heap]
MOV R8, [R10 + minheap.array]
MOV RCX, [R10 + minheap.elements]
MOV R9, [R10 + minheap.len]

MOV [R8 + R9*SIZE_INT], ESI
MOV [RCX + R9*SIZE_INT], EDX
INC [R10 + minheap.len]
INC [RDI + priority_queue.size]
DEC R9
MOV RDI, R10
MOV ESI, R9
CALL minheap@siftUp
RET

priority_queue@pop:
; ----------------------------------------------------------------------------
; Function: priority queue pop.
; Description:
;   Pops the first element in both the value and element array of the minheap and returns NodeTuple containing both.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (NodeTuple*)    NodeTuple containing value, elem, or null (0).
;   Clobbers - RDI, RSI, RCX, RDX, R10, R8, R9.
; ---------------------------------------------------------------------------
CMP [RDI + priority_queue.size], 0
SETNE AL
MOVZX RAX, AL
JE .short_circuit

MOV RSI, [RDI + priority_queue.heap]
MOV R10, [RSI + minheap.array]
MOV R8, [RSI + minheap.elements]

MOV RDX, [R10]
PUSH RDX
MOV RDX, [R8]
PUSH RDX

MOV RCX, [RDI + priority_queue.size]
DEC RCX
MOV R9, RCX
MOV [RDI + priority_queue.size], RCX
MOV ECX, [R10 + RCX*SIZE_INT]
MOV [R10], ECX
MOV R9D, [R8 + R9*SIZE_INT]
MOV [R8], R9D

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, NodeTuple_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL

POP RSI
POP RDX
MOV [RAX + NodeTuple.value], EDX
MOV [RAX + NodeTuple.element], ESI

.short_circuit:
RET

priority_queue@peek:
; ----------------------------------------------------------------------------
; Function: priority queue peek.
; Description:
;   Peeks at the first element in both the value and element array of the minheap and returns NodeTuple containing both.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (NodeTuple*)    NodeTuple containing value, elem, or null (0).
;   Clobbers - RDI, RSI, RCX, RDX, R10, R8, R9.
; ---------------------------------------------------------------------------
CMP [RDI + priority_queue.size], 0
SETNE AL
MOVZX RAX, AL
JE .short_circuit

MOV RSI, [RDI + priority_queue.heap]
MOV R10, [RSI + minheap.array]
MOV R8, [RSI + minheap.elements]

MOV R10, [R10]
MOV R8, [R8]
PUSH R10
PUSH R8

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, NodeTuple_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL

POP RSI
POP RDX
MOV [RAX + NodeTuple.value], EDX
MOV [RAX + NodeTuple.element], ESI
.short_circuit:
RET

priority_queue@isEmpty:
; ----------------------------------------------------------------------------
; Function: priority queue isEmpty.
; Description:
;   Self explanatory.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (bool)          Boolean denoting whether PQ is empty (true) or not (false).
;   Clobbers - RAX, RDI.
; ---------------------------------------------------------------------------
MOV RAX, 1
CMP [RDI + priority_queue.size], 0
SETE AL
MOVZX RAX, AL
RET

priority_queue@size:
; ----------------------------------------------------------------------------
; Function: priority queue size.
; Description:
;   Self explanatory.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   EAX - (int)           Size of PQ/Minheap.
;   Clobbers - RAX, RDI.
; ---------------------------------------------------------------------------
MOV RAX, [RDI + priority_queue.size]
RET

priority_queue@decreaseKey:
; ----------------------------------------------------------------------------
; Function: priority queue decreaseKey.
; Description:
;   Decrease priority of given symbol.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - (int)           Symbol.
;   RDX - (int)           Replacement priority.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - RDI, RSI, RCX, RDX, R10, R8.
; ---------------------------------------------------------------------------

MOV R10, [RDI + priority_queue.heap]
MOV R8,  [R10 + min_heap.array]
MOV R10, [R10 + min_heap.elements]
MOV RCX, 0
    .search: ; I really don't like having to implement a linear search, but a hashtable will take way too long to implement.
        CMP RCX, [RDI + priority_queue.size]
        JAE .short_circuit ;Not found
        MOV RCX, [R10 + RCX*SIZE_INT]
        CMP RCX, RSI
        JNE .search
MOV [R8 + RCX*SIZE_INT], RDX


MOV RDI, [RDI + priority_queue.heap]
MOV ESI, RCX
CALL minheap@siftUp
.short_circuit:
RET

priority_queue@construct:
; ----------------------------------------------------------------------------
; Function: Priority Queue Constructor
; Description:
;   Restores min-heap by moving new element upward.
; Parameters:
;   RDI - (int)           Allowing size to be defined ahead of time so there's no slow and annoying SYS_MREMAP. (SIZE OF MMAP, NOT ACTUAL HEAP SIZE!)
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (PriorityQueue*)Ptr to new PQ.
;   Clobbers - RAX, RDI, RSI, RDX, R10, R8, R9
; ---------------------------------------------------------------------------
PUSH RBP
MOV RBP, RSP
SUB RSP, priority_queue@construct.STACK_INIT

PUSH RDI
PUSH RDI
PUSH RDI
MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, priority_queue_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - priority_queue@construct.PQPtr], RAX
MOV [RAX + priority_queue.size], 0

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
POP RSI ; size pushed to stack earlier.
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV RDI, RAX

MOV [RBP - priority_queue@construct.PQPtr], RAX
MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
POP RSI ; size pushed to stack earlier.
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV RSI, RAX

POP RDX ; Size, again
CALL minheap@construct
MOV RDI, [RBP - priority_queue@construct.PQPtr]
MOV [RDI + priority_queue.heap], RAX

ADD RSP, priority_queue@construct.STACK_INIT
MOV RSP, RBP
POP RBP
RET

priority_queue@destruct:
; ----------------------------------------------------------------------------
; Function: Priority Queue Destructor
; Description:
;   Destructs Priority Queue
; Parameters:
;   RDI - (PriorityQueue*)Ptr to priority queue.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              
;   Clobbers - RDI, RSI, RDX.
; ---------------------------------------------------------------------------
PUSH RDI
MOV RDI, [RDI + priority_queue.heap]
CALL minheap@destruct

MOV RAX, SYS_MUNMAP
POP RDI
MOV RSI, priority_queue_size
SYSCALL
XOR RDI, RDI ; Killing RDI so stale ptr isn't passed on.
RET

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
        MOV R10, [R8 + R10*SIZE_INT]
        CMP RDX, R10
        JAE .sift_end
        MOV RDI, RBX
        MOV RDI, [RBX + minheap.array]
        MOV RSI, [RBP - minheap@siftUp.index]
        MOV RDX, RAX
        CALL minheap@swap
        MOV RDI, RBX
        MOV RDI, [RDI + minheap.elements]
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
        MOV RDX, [RAX + RDX*SIZE_INT]
        CMP RDX, RCX
        SETB [RBP - minheap@siftDown.conditional_BOOLs-2]
        CMP [RBP - minheap@siftDown.conditional_BOOLs-1], minheap@siftDown.conditional_BOOLs-ACCEPT
        CMOVB R9, [RBP - minheap@siftDown.right]
        
        MOV RAX, [RBX + min_heap.array]
        MOV R11, R9
        MOV R11, [RAX + R11*SIZE_INT]
        MOV R12, [RBP - minheap@siftDown.index]
        MOV R12, [RAX + R12*SIZE_INT]
        CMP R11, R12
        JAE .sift_exit
        MOV RDI, RBX
        MOV RDI, [RDI + min_heap.array]
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
; ----------------------------------------------------------------------------
; Function: Minheap Constructor
; Description:
;   Constructs minheap with information generated by priority_queue@construct
; Parameters:
;   RDI - (int[]*)        Value array.
;   RSI - (int[]*)        Element array.
;   EDX - (int)           Array size in memory.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (Minheap*)      Minheap ptr.
;   Clobbers - RAX
; ---------------------------------------------------------------------------
PUSH RDI
PUSH RSI
PUSH RDX

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, min_heap_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL

POP RDX
POP RSI
POP RDI

MOV [RAX + min_heap.array], RDI
MOV [RAX + min_heap.elements], RSI
MOV [RAX + min_heap.array_size], RDX
MOV [RAX + min_heap.len], 0
RET

minheap@destruct:
; ----------------------------------------------------------------------------
; Function: Minheap Destructor
; Description:
;   Destructs Minheap; only to be called by priority_queue@destruct
; Parameters:
;   RDI - (Minheap*)     Ptr to minheap.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              
;   Clobbers - RDI, RSI, RDX.
; ---------------------------------------------------------------------------
MOV RDX, RDI

MOV RAX, SYS_MUNMAP
MOV RDI, [RDX + min_heap.array]
MOV RSI, [RDX + min_heap.arr_size]
SYSCALL

MOV RAX, SYS_MUNMAP
MOV RDI, [RDX + min_heap.elements]
MOV RSI, [RDX + min_heap.arr_size]
SYSCALL

MOV RAX, SYS_MUNMAP
MOV RDI, [RDX + min_heap.array]
MOV RSI, min_heap_size
SYSCALL

XOR RDX, RDX ; I want to kill this register so a stale ptr to minheap isn't passing on after this function's lifetime.
RET
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
;   RDI - (char[]*)       Pointer to string to convert to integer.
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
    

