; MACROS

%MACRO MMAP_PUSH 0
PUSH RDI
PUSH RSI
PUSH RDX
PUSH RCX
PUSH R10
PUSH R8
PUSH R9
PUSH R11
%ENDMACRO
%MACRO MMAP_POP 0
POP R11
POP R9
POP R8
POP R10
POP RCX
POP RDX
POP RSI
POP RDI
%ENDMACRO

;Exit codes
%DEFINE EXIT_OK 0

%DEFINE INVALID_ARGC 1
%DEFINE INVALID_SRCDST 2
%DEFINE INVALID_NUM_NEG 3
%DEFINE INVALID_CHAR 4
%DEFINE INVALID_NUM_VERTS 5
%DEFINE INVALID_NOT_SQUARE 6
%DEFINE INVALID_STATE 7
%DEFINE INVALID_EMPTY 8
%DEFINE INVALID_BAD_STR 9

%DEFINE VALID_ARGC 4

; CONSTANTS
%DEFINE MUL_2 1
%DEFINE MUL_4 2
%DEFINE MUL_INT 2
%DEFINE MUL_LONG 3
%DEFINE DIV_2 1
%DEFINE SIZE_INT 4
%DEFINE SIZE_LONG 8
%DEFINE EMPTY_INPUT 0
%DEFINE INT_MAX 0xFFFFFFFF
%DEFINE NULL 0
%DEFINE FALSE 0
%DEFINE TRUE 1
%DEFINE MAX_STR_INT 11 ; 10 (Max Int) + 1 (Null)

%DEFINE UNSEEN 0
%DEFINE SEEN 1

%DEFINE NO_CONNECTION 0

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
%DEFINE minheap@siftDown.conditional_BOOLs~1 36
%DEFINE minheap@siftDown.conditional_BOOLs~2 40
%DEFINE minheap@siftDown.conditional_BOOLs~ACCEPT 0xFFFFFFFFFFFFFFFF

%DEFINE minheap@siftUp.STACK_INIT 16
%DEFINE minheap@siftUp.index 8
%DEFINE minheap@siftUp.parent 16

%DEFINE priority_queue@construct.STACK_INIT 8
%DEFINE priority_queue@construct.PQPtr 8

%DEFINE parseSRCDST.STACK_INIT 8
%DEFINE parseSRCDST.strlen 8

%DEFINE parseVertices.STACK_INIT 64
%DEFINE parseVertices.strlen 8
%DEFINE parseVertices.SRC 16
%DEFINE parseVertices.DST 24
%DEFINE parseVertices.NumPtr 32
%DEFINE parseVertices.PrevState 40
%DEFINE parseVertices.NumElems 48
%DEFINE parseVertices.CurrentArray 56
%DEFINE parseVertices.NumVertices 64


;SYSCALLS
;STDOUT/OUT
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

%DEFINE dijkstra.STACK_INIT 72
%DEFINE dijkstra.PriorityQueue 8
%DEFINE dijkstra.prev 16
%DEFINE dijkstra.dist 24
%DEFINE dijkstra.SRC 32
%DEFINE dijkstra.graph 40
%DEFINE dijkstra.x 48
%DEFINE dijkstra.y 56
%DEFINE dijkstra.numVerts 64
%DEFINE dijkstra.currentROw 72





section .rodata

Error:
    .msg db 'Usage: please provide three inputs: a serialized matrix, a source node and a destination node'
    .len equ $- .msg
    
Err_Table: ; This is absurd but this because of CMOV not allowing immediates.
    dq 0
    dq -1
    dq -2
    dq -3
    dq -4
    dq -5
    dq -6
    dq -7
    dq -8
    dq -9

BOOLs:
    .TRUE dq 1
    .FALSE dq 0   

section .data

Error_state:
    .CODE db 0

struc min_heap
    .max_len resq 1
    .size resq 1
    .elems resq 1
endstruc

struc NodeTuple
    .value resd 1
    .element resd 1
endstruc

; I want this priority queue as it acts as a great container for the minheap
; and allows for easy abstraction of minheap methods.
struc priority_queue
    .size resq 1
    .max_len resq 1
    .heap resq 1
endstruc    

section .bss

section .text

global _start

_start:
INT3
PUSH RBP
MOV RBP, RSP
SUB RSP, _start.STACK_INIT
MOV RSI, [RBP + _start.argv1]
CMP QWORD [RBP + _start.argc], VALID_ARGC
CMOVNE RDI, [Err_Table + INVALID_ARGC*SIZE_LONG]
INT3
CMOVNE RSI, [RBP + _start.argc]
JNE .error

MOV RAX, [RBP + _start.argv1]
MOV RCX, 0
MOV RDX, 0
MOV RBX, 0
.count_commas:
    CMP BYTE [RAX + RCX], 0
    JE .count_end
    CMP BYTE [RAX + RCX], ','
    JNE .skip
    INC RBX
    .skip:
    INC RCX
    JMP .count_commas
.count_end:  
INC RBX
MOV RDI, RBX
CALL ezsqrt

MOV [RBP - _start.NumVerts], RAX
CMP RAX, -1
CMOVE RDI, [Err_Table + INVALID_NOT_SQUARE*SIZE_LONG]
JE .error
MOV RDI, [RBP + _start.argv2]
CALL parseSRCDST
MOV [RBP - _start.SRC], RAX
MOV RDI, [RBP + _start.argv3]
CALL parseSRCDST
MOV [RBP - _start.DST], RAX

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, [RBP - _start.NumVerts]
SHL RSI, MUL_LONG
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - _start.graph], RAX
MOV R12, [RBP - _start.NumVerts]
MOV R13, [RBP - _start.graph]
    .GRAPH_LOOP:
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, SIZE_LONG*1
    XOR RCX, RCX
    MOV QWORD [RBP - SIZE_LONG*1], 0
        .GRAPH_Inner:
            MOV RCX, [RBP - SIZE_LONG*1]
            CMP RCX, R12
            JAE .GRAPH_Exit
            
            PUSH RCX
            MOV RAX, SYS_MMAP
            MOV RDI, NO_ADDR
            MOV RSI, R12
            SHL RSI, MUL_INT
            .chk_sze: INT3
            MOV RDX, PROT_READ | PROT_WRITE
            MOV R10, MAP_SHARED | MAP_ANONYMOUS
            MOV R8, NO_FD
            MOV R9, NO_OFFSET
            SYSCALL
            .graph_mchk: INT3
            POP RCX
            MOV [R13 + RCX*SIZE_LONG], RAX
            .graph_regchk: INT3
            INC RCX
            MOV [RBP - SIZE_LONG*1], RCX
            JMP .GRAPH_Inner        
    .GRAPH_Exit:
        ADD RSP, SIZE_LONG*1
        MOV RSP, RBP
        POP RBP    
MOV RDI, [RBP + _start.argv1]
MOV RSI, [RBP - _start.graph]
MOV RDX, [RBP - _start.NumVerts]
.print_graph: INT3
CALL parseVertices
MOV RDI, [RBP - _start.SRC]
MOV RSI, [RBP - _start.graph]
MOV RDX, [RBP - _start.NumVerts]
CALL dijkstra
.dijkstra_complete:
MOV RCX, [RBP - _start.DST]
MOV EBX, [RAX + RCX*SIZE_INT]
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
MOV R15, RDI
MOV RSI, RAX
CALL itoa
MOV RAX, R10
MOV RAX, SYS_WRITE
MOV RDI, STDOUT
MOV RSI, R15
MOV RDX, R10
SYSCALL

MOV RAX, SYS_EXIT
MOV RDI, [Err_Table+EXIT_OK*SIZE_LONG]
SYSCALL


.error:
    PUSH RDI
    PUSH RSI
    MOV RAX, SYS_WRITE
    MOV RDI, STDOUT
    MOV RSI, Error.msg
    MOV RDX, Error.len
    SYSCALL
    
    MOV RAX, SYS_EXIT
    POP RSI
    POP RDI
    INT3
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
.itoa_check: INT3
XOR RCX, RCX
MOV RAX, RDI
MOV RBX, 10
    .loop:
        CMP RAX, 0
        JE .ext
        XOR RDX, RDX
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
        MOV [RSI+RCX], R10B
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
PUSH RBP
MOV RBP, RSP
SUB RSP, parseSRCDST.STACK_INIT

MOV RCX, 0
    .validate:
    MOV DL, BYTE [RDI+RCX]
    JMP [.jmpTable + RDX*SIZE_LONG]
    .jmpTable:
        dq .zero
        times 47 dq .error
        times 10 dq .num
        times 198 dq .error
    .cont:
        MOV RSI, RCX
        CALL atoi
        
        MOV EAX, EAX
        ADD RSP, parseSRCDST.STACK_INIT
        MOV RSP, RBP
        POP RBP
        RET
    .zero:
        CMP RCX, 0
        CMOVE RAX, [Err_Table+INVALID_SRCDST*SIZE_LONG]
        JE .error
        JNE .cont
    .num:
        INC RCX
        JMP .validate
    .error:
        PUSH RAX
        MOV RAX, SYS_WRITE
        MOV RDI, STDOUT
        MOV RSI, Error.msg
        MOV RDX, Error.len
        SYSCALL
        
        MOV RAX, SYS_EXIT
        POP RDI
        INT3
        SYSCALL

parseVertices:
; ----------------------------------------------------------------------------
; Function: Parse Vertices.
; Description:
;   Parses given vertices from array and checks for errors.
;   Parsed through Finite State Machine.
; Parameters:
;   RDI - (char[]*)       Ptr to vertice char array.
;   RSI - (int[][]*)      Ptr to graph 2d array.
;   RDX - (int)           Number of vertices.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (int)           0 (OK)
;   Clobbers - RAX, RDI, RSI, RCX, RDX.
; ---------------------------------------------------------------------------
;Previous States
    %DEFINE Parse.STATE.START 0000b
    %DEFINE Parse.STATE.NUM 0001b
    %DEFINE Parse.STATE.COMMA 0010b
    %DEFINE Parse.STATE.SPACE 0100b
    %DEFINE Parse.STATE.ZERO 1000b
PUSH RBP
MOV RBP, RSP
SUB RSP, parseVertices.STACK_INIT
MOV [RBP - parseVertices.SRC], RDI
MOV [RBP - parseVertices.DST], RSI
MOV QWORD [RBP - parseVertices.NumVertices], RDX
MOV QWORD [RBP - parseVertices.NumElems], 0
MOV QWORD [RBP - parseVertices.strlen], 0
MOV QWORD [RBP - parseVertices.PrevState], Parse.STATE.START
PUSH RBX
PUSH R12
MOV RAX, RDI
CMP AL, EMPTY_INPUT
CMOVE RAX, [Err_Table+INVALID_EMPTY*SIZE_LONG]
JE .error

MOV RCX, 0
XOR RBX, RBX
MOV [RBP - parseVertices.NumPtr], RDI
    .validate:
    MOV DL, BYTE [RDI+RCX]
    
    JMP [.jmpTable + RDX*SIZE_LONG]
    .jmpTable:
        dq .zero
        times 31 dq .error
        dq .space
        times 11 dq .error
        dq .comma
        times 3 dq .error
        times 10 dq .num
        times 197 dq .error
    
    .num:
        CMP QWORD [RBP - parseVertices.PrevState], Parse.STATE.START
        JE .errSkip
        PUSH RDI
        PUSH RAX
        MOV RAX, [RBP - parseVertices.NumPtr]
        MOV RAX, [RAX]
        ADD RDI, RCX
        CMP QWORD [RBP - parseVertices.PrevState], Parse.STATE.SPACE
        CMOVE RAX, RDI
        MOV [RBP - parseVertices.NumPtr], RAX
        POP RAX
        POP RDI
        JE .errSkip
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR*SIZE_LONG]
        JMP .error
        .errSkip: 
        INC QWORD [RBP - parseVertices.strlen]
        INC RCX
        MOV QWORD [RBP - parseVertices.PrevState], Parse.STATE.NUM
        JMP .validate
        
    .comma:
        CMP QWORD [RBP - parseVertices.PrevState], Parse.STATE.NUM
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR*SIZE_LONG]
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
        .atoi_res: INT3
        MOV RCX, [RBP - parseVertices.NumElems]
        MOV R12, [RBP - parseVertices.DST]
        .chkDstVert: INT3
        MOV RDI, [R12 + RBX*SIZE_LONG]
        .chkDstRdi: INT3
        MOV [RDI + RCX*SIZE_INT], EAX
        .arr_chk: INT3
        .skip_move:
        POP RDX
        POP RCX
        POP RSI
        POP RDI
        POP RAX
        CMP QWORD [RBP - parseVertices.PrevState], Parse.STATE.ZERO
        JE .zero_cont
        
        MOV QWORD [RBP - parseVertices.PrevState], Parse.STATE.COMMA
        MOV QWORD [RBP - parseVertices.strlen], 0
        INC RCX
        INC QWORD [RBP - parseVertices.NumElems]
        PUSH RCX
        MOV RCX, [RBP - parseVertices.NumElems]
        CMP RCX, [RBP - parseVertices.NumVertices]
        POP RCX
        JB .skipReset
        MOV QWORD [RBP - parseVertices.NumElems], 0
        INC RBX
        INT3
        .skipReset: 
        JMP .validate     
    .space:
        CMP QWORD [RBP - parseVertices.PrevState], Parse.STATE.COMMA
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR*SIZE_LONG]
        JNE .error
        INC RCX
        MOV QWORD [RBP - parseVertices.PrevState], Parse.STATE.SPACE
        JMP .validate
    .zero:
        CMP QWORD [RBP - parseVertices.PrevState], Parse.STATE.START
        JE .skip_err
        CMP QWORD [RBP - parseVertices.PrevState], Parse.STATE.NUM
        CMOVNE RDI, [Err_Table+INVALID_BAD_STR*SIZE_LONG]
        JNE .error       
        CMP QWORD [RBP - parseVertices.NumElems], 0
        CMOVE RDI, [Err_Table+INVALID_BAD_STR*SIZE_LONG]
        JE .error
        .skip_err:
        MOV QWORD [RBP - parseVertices.PrevState], Parse.STATE.ZERO
        JMP .zero_jmp ; I don't like this backwards GOTO.
        .zero_cont:
        JMP .cont
        
    .cont:
        MOV RAX, 0
        POP R12
        POP RBX
        ADD RSP, parseVertices.STACK_INIT
        MOV RSP, RBP
        POP RBP
        RET
    .error:
        ;For debugging, I can also add pointers, or other info into other registers before SYSCALLing.
        MOV RAX, SYS_EXIT
        MOV RDI, [RBP - parseVertices.PrevState]
        INT3
        SYSCALL
        
        
        
        
        

dijkstra:
; ----------------------------------------------------------------------------
; Function: priority queue push.
; Description:
;   The algorithm of study itself, Dijkstra.
; Parameters:
;   EDI - (int)           SRC.
;   RSI - (int[][]*)      Graph to vertice&edges.
;   EDX - (int)           # Vertices.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (int[]*)        Array of distances.
;   Clobbers - RAX, RDI, RSI, RDX, R10, R11.
; ---------------------------------------------------------------------------
PUSH RBP
MOV RBP, RSP
SUB RSP, dijkstra.STACK_INIT
PUSH RBX
PUSH R12
PUSH R13
PUSH R14
MOV [RBP - dijkstra.SRC], RDI
MOV [RBP - dijkstra.graph], RSI
MOV [RBP - dijkstra.numVerts], RDX
MOV [RBP - dijkstra.x], 0
MOV [RBP - dijkstra.y], 0

MOV RDX, [RBP - dijkstra.SRC]
MOV RSI, [RBP - dijkstra.graph]
CALL dijkstra~GetRow
MOV [RBP - dijkstra.currentRow], RAX
MOV RSI, [RBP - dijkstra.SRC] 
MOV RDI, [RBP - dijkstra.graph]

MMAP_PUSH
MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, [RBP - dijkstra.numVerts]
SHL RSI, SIZE_INT
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP _ dijkstra.prev], RAX

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, [RBP - dijkstra.numVerts]
SHL RSI, SIZE_INT
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP _ dijkstra.dist], RAX
MMAP_POP
MOV RCX, 0
MOV R8, [RBP - dijkstra.prev]
MOV R9, [RBP - dijkstra.dist]
    .dists_loop:
        CMP RCX, [RBP - dijkstra.numVerts]
        JE .dists_ext
        MOV [R8 + RCX*SIZE_INT], 0
        MOV [R9 + RCX*SIZE_INT], INT_MAX
        INC RCX
        JMP .dists_loop
.dists_ext:
MOV RCX, [RBP - dijkstra.numVerts]     
MOV [R9 + RCX*SIZE_INT], 0

MOV RDI, RCX
CALL priority_queue@construct
MOV [RBP - dijkstra.PriorityQueue], RAX         

MOV RCX, [RBP - dijkstra.numVerts]
MOV RDX, [RBP - dijkstra.currentRow]
    .PQ_INIT:
        CMP RCX, [RBP - dijkstra.numVerts]
        JE .PQ_INIT_EXIT
        
        MOV EDI, ECX
        MOV ESI, [RDX + RCX*SIZE_INT]
        CALL dijkstra~GenerateTuple
        
        MOV RDI, [RBP - dijkstra.PriorityQueue]
        MOV RSI, RAX
        CALL priority_queue@add
        
        INC RCX
        JMP .PQ_INIT                                                      
.PQ_INIT_EXIT: 
MOV RDI, [RBP - dijkstra.PriorityQueue]
    .PQ_LOOP:
        CALL priority_queue@isEmpty
        CMP RAX, [BOOLs.TRUE]
        JE .PQ_EXIT
        
        CALL priority_queue@remove
        MOV EBX, [RAX + Node_Tuple.element]
        MOV [RBP - dijkstra.x], EBX
        MOV RCX, [RBP - dijkstra.dist]
        MOV ECX, [RCX + RBX*SIZE_INT]
        MOV RBX, RAX
        CMP [RBX + Node_Tuple.value], ECX
        JA .PQ_LOOP
        
        
        
        MOV RDI, [RBP - dijkstra.graph]
        MOV ESI, [RBX + Node_Tuple.value]
        CALL dijkstra~GetRow
        MOV [RBP - dijkstra.currentRow], RAX
        MOV R11, [RBP - dijkstra.dist]
        MOV RCX. 0
        .neighbor_loop:
            CMP DWORD [R11 + RCX*SIZE_INT], 0
            JE .neighbor_iterate
            
            MOV EDX, [R11 + RCX*SIZE_INT]
            MOV R12D, [RBX + Node_Tuple.element]
            MOV R12D, [R11 + R12*SIZE_INT]
            ADD R12D, EDX
            MOV R13D, [R11 + RCX*SIZE_INT]
            CMP R12D, R13D
            JB .neighbor_iterate
            MOV [R11 + RCX*SIZE_INT], R12D
            
            MOV RDI, RCX
            MOV ESI, [R11 + RCX*SIZE_INT]
            CALL dijkstra~GenerateTuple
            
            MOV RDI, [RBP - dijkstra.PriorityQueue]
            MOV RSI, RAX
            CALL priority_queue@add
            .neighbor_iterate:
            INC RCX
            JMP .neighbor_loop
        
.PQ_EXIT:
POP R14
POP R13
POP R12                            
POP RBX
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
;   EDI - (int)           Element.
;   ESI - (int)           Value.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (NodeTuple*)    Generated Tuple.
;   Clobbers - 
; ---------------------------------------------------------------------------
MMAP_PUSH

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, NodeTuple_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV DWORD [RAX + NodeTuple.value], ESI
MOV DWORD [RAX + NodeTuple.element], EDI

MMAP_POP
RET

dijkstra~GetRow:
; ----------------------------------------------------------------------------
; Function: Dijkstra Get Row
; Description:
;   Helper method for dijkstra to grab the address of the needed row given a graph.
; Parameters:
;   RDI - (int[][]*)      Graph.
;   RSI - (int)           Row #
;   RDX - ()              Unused
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (int[]*)        Row.
;   Clobbers - RAX.
; ---------------------------------------------------------------------------  
MOV RAX, [RDI + RSI*SIZE_LONG]
RET


priority_queue@add:
; ----------------------------------------------------------------------------
; Function: priority queue add.
; Description:
;   Adds new value into minheap.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - (NodeTuple*)    Tuple that contains distance and element.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              RAX == 0 (Full), RAX == 1 (Success).
;   Clobbers - 
; ---------------------------------------------------------------------------
MMAP_PUSH ;Having abstracted the min heap allows me to do this.
MOV EDX, [RDI + priority_queue.size]
CMP EDX, [RDI + priority_queue.max_len]
CMOVE RAX, [BOOLs.FALSE]
JE .ext
MOV R8, [RDI + priority_queue.heap]
MOV [R8 + RDX*SIZE_LONG], RSI
INC EDX
INC [RDI + priority_queue.size]
MOV RDI, R8
MOV ESI, EDX
CALL minheap@siftUp
MOV RAX, [BOOLs.TRUE]
.ext:
MMAP_POP
RET

priority_queue@remove:
; ----------------------------------------------------------------------------
; Function: priority queue remove.
; Description:
;   Removes the first element in both the value and element array of the minheap and returns NodeTuple containing both.
;   Preserves RDI
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (NodeTuple*)    NodeTuple containing value, elem, or nil (0).
;   Clobbers - RDI, RSI, RDX, R10, R8, R9.
; ---------------------------------------------------------------------------
PUSH RDI
CMP DWORD [RDI + priority_queue.size], 0
CMOVA RAX, [BOOLs.FALSE]
JE .ext:

MOV RSI, [RDI + priority_queue.heap]
MOV RCX, [RDI + min_heap.elems]
MOV RAX, [RCX]
PUSH RAX

MOV EDX, [RDI + priority_queue.size]
DEC EDX
MOV R8, [RCX + RDX*SIZE_LONG]
MOV [RCX], R8

MOV RDI, RSI
MOV ESI, 0
CALL minheap@siftDown
POP RAX
.ext:
POP RDI
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
;   RAX - (NodeTuple*)    NodeTuple containing value, elem, or nil (0).
;   Clobbers - RDI, RSI, RCX, RDX, R10, R8, R9.
; ---------------------------------------------------------------------------
CMP DWORD [RDI + priority_queue.size], 0
CMOVA RAX, [BOOLs.FALSE]
JE .ext:
MOV RSI, [RDI + priority_queue.heap]
MOV RCX, [RSI + min_heap.elems]
MOV RAX, [RCX]
.ext:
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
MOV RAX, 0
CMP QWORD [RDI + priority_queue.size], 0
CMOVA RAX, [BOOLs.FALSE]
CMOVE RAX, [BOOLs.TRUE]
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
;   Decrease priority of given symbol. Implemented through linear search because implementing a hashmap would take too long for now; possibility for improvement.
; Parameters:
;   RDI - (PriorityQueue*)This* priority queue.
;   ESI - (int)           Symbol.
;   EDX - (int)           Replacement priority.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   EAX - (int)           EAX == 0 : NOT IN QUEUE; EAX == 1 : IN QUEUE.
;   Clobbers - RAX, RDI, RSI, RCX, RDX, R10, R8.
; ---------------------------------------------------------------------------
MOV RDX, [RDI + priority_queue.heap]
MOV RCX, 0
    .search:
        CMP ECX, [RDI + priority_queue.size]
        CMOVE RAX, [BOOLs.FALSE]
        JE .ext
        MOV R10, [RDX + RCX*SIZE_LONG]
        CMP ESI, [R10 + Node_Tuple.element]
        JE .success
        INC ECX
        JNE .search
.success:
MOV R10, [RDX + RCX*SIZE_LONG]
MOV [R10 + Node_Tuple.value], EDX 
MOV ESI, ECX
CALL minheap@siftUp        
MOV RAX, [BOOLs.TRUE]        
.ext:      
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
PUSH R13
PUSH R12
MOV R12, RDI

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, priority_queue_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - priority_queue@construct.PQPtr], RAX
MOV QWORD [RAX + priority_queue.size], 0
MOV QWORD [RAX + priority_queue.max_len], R12

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, R12
SHL RSI, MUL_LONG
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL

MOV RDI, RAX
MOV RSI, R12
CALL minheap@construct
MOV RDI, [RBP - priority_queue@construct.PQPtr]
MOV [RDI + priority_queue.heap], RAX

POP R12
POP R13
MOV RAX, [RBP - priority_queue@construct.PQPtr]
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
; Function: minheap sift up
; Description:
;   Restores min-heap by moving new element upward.
; Parameters:
;   RDI - (Minheap*)      This* minheap.
;   ESI - (int)           Index.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - RDI, RSI, RCX, RDX, R10, R8, R9, R11.
; ---------------------------------------------------------------------------
PUSH RBP
MOV RBP, RSP
SUB RSP, minheap@siftUp.STACK_INIT

    .sift_loop:
        CMP ESI, 0
        JE .sift_ext
        PUSH RDI
        MOV RDI, RSI
        CALL minheap@parent
        MOV R11, RDI
        POP RDI
        MOV RDX, [RDI + min_heap.elems]
        MOV R8, [RDX + RAX*SIZE_LONG]
        MOV R9, [RDX + RSI*SIZE_LONG]
        MOV ECX, [R8 + Node_Tuple.value]
        CMP ECX, [R9 + Node_Tuple.value]
        JBE .sift_ext
        MOV EDX, EAX
        MOV ESI, R11D
        CALL minheap@swap
        MOV RSI, RAX
        JMP .sift_loop
.sift_ext:
ADD RSP, minheap@siftUp.STACK_INIT
MOV RSP, RBP
POP RBP
RET
minheap@siftDown:
; ----------------------------------------------------------------------------
; Function: minheap sift down.
; Description:
;   Restores min-heap by moving root downward.
; Parameters:
;   RDI - (Minheap*)      This* minheap.
;   ESI - (int)           Index.
;   EDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()          None.
;   Clobbers - RAX, RDI, RSI, RCX, RDX, R10, R8, R9, R11.
; ---------------------------------------------------------------------------
PUSH RBP
MOV RBP, RSP
SUB RSP, minheap@siftDown.STACK_INIT

    .sift:
        MOV RCX, RDI
        MOV R10D, ESI
        MOV RDI, RSI
        CALL minheap@left
        MOV R9, RAX
        CALL minheap@right
        MOV R8, RAX
        MOV EDX, EDI
        
        MOV R11, [RCX + min_heap.elems]
        CMP R9D, [RCX + min_heap.size]
        JAE .skpLft
        MOV RDX, R9
        .skpLft:
        CMP R8D, [RCX + min_heap.size]
        JAE .skpRgt
        MOV RDX, R8
        .skpRgt:
        CMP RDX, R10
        JE .siftEXT
        PUSH RCX
        PUSH RDX
        MOV RDI, RCX
        MOV RSI, R10
        CALL minheap@swap
        POP RSI
        POP RDI
        JMP .sift
        
.siftEXT:
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
;   RDI - (Minheap*)      Minheap to operate on.
;   ESI - (int)           Index one.
;   EDX - (int)           Index two.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - R8, R9.
; ---------------------------------------------------------------------------
MOV R10, [RDI + min_heap.elems]
MOV R8, [R10 + RSI*SIZE_LONG]
MOV R9, [R10 + RDX*SIZE_LONG]
MOV [R10 + RSI*SIZE_LONG], R9
MOV [R10 + RDX*SIZE_LONG], R8
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
MOV EAX, EDI
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
MOV EAX, EDI
SHL RAX, MUL_2
INC RAX
RET
minheap@right:
; ----------------------------------------------------------------------------
; Function: minheap left
; Description:
;   Grabs right element index relative to given index.
; Parameters:
;   EDI - (minheap)       Index.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Right element index.
;   Clobbers - RAX
; ---------------------------------------------------------------------------
MOV EAX, EDI
SHL RAX, MUL_2
ADD RAX, 2
RET
minheap@construct:
; ----------------------------------------------------------------------------
; Function: Minheap Constructor
; Description:
;   Constructs minheap with information generated by priority_queue@construct
; Parameters:
;   RDI - (long[]*)       Element array.
;   ESI - (int)           Array size in memory.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (Minheap*)      Minheap ptr.
;   Clobbers - RAX
; ---------------------------------------------------------------------------
MMAP_PUSH

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, min_heap_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL

MMAP_POP

MOV [RAX + min_heap.elems], RDI
MOV [RAX + min_heap.max_len], ESI
MOV QWORD [RAX + min_heap.size], 0

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
;   EDI - (long)          Input value to sqrt.
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
        CMP EAX, EDI
        JE .ext
        INC RCX
        CMOVA RAX, RDX
        JA .short_circuit
        JB .sqrt_loop
    .ext:
    MOV RAX, RCX
    .short_circuit:
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
;   Clobbers - RAX, RDX, RCX, R10. 
; ---------------------------------------------------------------------------
    PUSH RBX
    .check_atoi: INT3
    
    MOV RCX, 0
    MOV RBX, 10
    MOV RAX, 0
    .loop:
        MOV R10B, [RDI + RCX]
        SUB R10B, '0'
        MUL RBX
        ADD EAX, R10D
        INC RCX
        JB .loop  
    .ext:
    .check_atoi2: INT3
    POP RBX
    RET
    

