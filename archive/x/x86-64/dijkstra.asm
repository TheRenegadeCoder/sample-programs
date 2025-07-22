;MACROS
%MACRO initilizeRBXRCXMinheap 0
        MOV RBX, [RBP - minheap@delete.This] ; For left child of heap.
        MOV RCX, [RBP - minheap@delete.This] ; For smallest child of heap.
        MOV RBX, [RBX + minheap.ptr]
        MOV RCX, [RCX + minheap.ptr]
%ENDMACRO 

;Exit codes
%DEFINE EXIT_OK 0
%DEFINE INVALID_ARGC -1
%DEFINE INVALID_SRC -2
%DEFINE INVALID_SRC -3
%DEFINE INVALID_NUM_NEG -4
%DEFINE INVALID_CHAR -5
%DEFINE INVALID_NUM_VERTS -6
%DEFINE INVALID_NOT_SQUARE -7

;Constants
%DEFINE EMPTY_INPUT 0
%DEFINE SHIFT_X8 3
%DEFINE SHIFT_X2 1

;SYSCALLS
;I/O
%DEFINE SYS_WRITE 1
%DEFINE STDOUT 1
;Memory
%DEFINE SYS_MMAP 9
;PROTS (RDX)
%DEFINE PROT_READ 0x01
%DEFINE PROT_WRITE 0x02
;FLAGS (R10)
%DEFINE MAP_SHARED
%DEFINE MAP_ANONYMOUS

%DEFINE SYS_MUNMAP 11
;Thread
%DEFINE SYS_EXIT 60

;Stack displacements

%DEFINE _start.STACK_INIT 16
%DEFINE _start.argc 8
%DEFINE _start.argv0 16
%DEFINE _start.argv1 24
%DEFINE _start.argv2 32
%DEFINE _start.argv3 40
; RBP+ ^
; RBP- v    
%DEFINE _start.minheap 8
%DEFINE _start.ret 16


%DEFINE parse_SRC_DST.STACK_INIT 16
%DEFINE parse_SRC_DST.argv_loc 8
%DEFINE parse_SRC_DST.strlen 16
%DEFINE parse_SRC_DST.atol 24

%DEFINE minheap@insert.STACK_INIT 24
%DEFINE minheap@insert.This 8
%DEFINE minheap@insert.index 16
%DEFINE minheap@insert.operatedIndex 24

%DEFINE minheap@delete.STACK_INIT 16
%DEFINE minheap@delete.This 8
%DEFINE minheap@delete.index 16


%DEFINE atol.STACK_INIT 8
%DEFINE atol.ret 8

section .rodata
minheap_vTable:
    dq minheap@right
    dq minheap@left
    dq minheap@swap
    dq minheap@parent
    dq minheap@min
    dq minheap@insert ; These three will be the most complex to implement.
    dq minheap@delete ; These three will be the most complex to implement.
    dq minheap@heapify ; These three will be the most complex to implement.
    dq minheap@construct

invalid:
    .msg db 'Usage: please provide three inputs: a serialized matrix, a source node and a destination node'
    .len equ $- .msg


section .data

src_dst:
    .src dq 0
    .dst dq 0  
struc minheap:
    ;Minheap will be used to implement priority queue.
    .vTable resq 1
    .ptr resq 1
    .vertPtr resq 1
    .size resd 1
    .max_size resd 1
endstruc

vertice_array:
    .ptr dq 0
    .size dq 0
    .vertices dq 0
    .dists dq 0

commas dq 0
section .bss

section .text
;Minheap code area (This will be a nightmare).
; ----------------------------------------------------------------------------
; Function: Right, left, parent vertex.
; Description:
;   Grabs the index of the right, left, or parent index, based on the given index in RDI.
; Parameters:
;   RDI - (long)          Index.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Right/left/parent index.
; ---------------------------------------------------------------------------
minheap@right:
    MOV RAX, RDI
    SHL RAX, 1
    ADD RAX, 2
    RET
minheap@left:
    MOV RAX, RDI
    SHL RAX, 1
    ADD RAX, 1
    RET
minheap@parent:
    MOV RAX, RDI
    SUB RAX, 1
    SHR RAX, 1
    RET
minheap@swap:
; ----------------------------------------------------------------------------
; Function: Minheap minimum element (root).
; Description:
;   Constructs the minheap.
; Parameters:
;   RDI - (Minheap*)      This.
;   RSI - (long)          Index one.
;   RDX - (long)          Index two.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None; RAX clobbered.
; ---------------------------------------------------------------------------
    ;Swap Distances
    MOV RAX, [RDI + minheap.vertPtr + RSI*8]
    MOV R10, [RDI + minheap.vertPtr + RDX*8]
    MOV [RDI + minheap.vertPtr + RDX*8], RAX
    MOV [RDI + minheap.vertPtr + RSI*8], R10
    ;Swap vertices
    MOV RAX, [RDI + minheap.vertPtr + RSI*8]
    MOV R10, [RDI + minheap.ptr + RDX*8]
    MOV [RDI + minheap.vertPtr + RDX*8], RAX
    MOV [RDI + minheap.vertPtr + RSI*8], R10
    RET

minheap@min:
; ----------------------------------------------------------------------------
; Function: Minheap minimum element (root). (poll).
; Description:
;   Gets minimum element of minheap and removes (poll), then returns minimum element.
; Parameters:
;   RDI - (Minheap*)      Ptr to minheap to pull from [0] of the array pointer. This ptr.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Minimum element (root) of the minheap tree.
; ---------------------------------------------------------------------------
    MOV RAX, [RDI + minheap.vertPtr]
    MOV RAX, [RAX] ;Load address in .vertPtr
    MOV RAX, [RAX] ;Load [0] in ptr
    PUSH RAX
    MOV RSI, RAX
    CALL minheap@delete
    POP RAX
    RET
minheap@constructor:
; ----------------------------------------------------------------------------
; Function: Minheap constructor
; Description:
;   Constructs the minheap.
; Parameters:
;   RDI - (long)          Maximum capacity of the inner array of the Minheap (allocated as RDI*8).
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (Minheap*)      Ptr to new Minheap object.
; ---------------------------------------------------------------------------
    PUSH RBP
    MOV RBP, RSP
    PUSH RDI
    
    MOV RAX, SYS_MMAP
    MOV RDI, minheap_size
    MOV RSI, PROT_READ | PROT|WRITE
    MOV RDX, MAP_SHARED | MAP_ANONYMOUS
    MOV R10, -1
    MOV R8, 0
    SYSCALL
    
    POP RDI
    
    PUSH RAX
    LEA RSI, minheap_vTable
    MOV [RAX + minheap.vTable], RSI
    ;Allocate an array for the minheap elements.
    MOV RAX, SYS_MMAP
    SHL RDI, SHIFT_X8 ;RDI * 8 bytes
    MOV RSI, PROT_READ | PROT_WRITE
    MOV RDX, MAP_SHARED | MAP_ANONYMOUS
    MOV R10, -1
    MOV R8, 0
    SYSCALL
    
    POP RDI
    MOV [RDI + minheap.ptr], RAX
    PUSH RAX
    LEA RSI, minheap_vTable
    MOV [RAX + minheap.vTable], RSI
    ;Allocate an array for the minheap elements.
    MOV RAX, SYS_MMAP
    SHL RDI, SHIFT_X8 ;RDI * 8 bytes
    MOV RSI, PROT_READ | PROT_WRITE
    MOV RDX, MAP_SHARED | MAP_ANONYMOUS
    MOV R10, -1
    MOV R8, 0
    SYSCALL
    
    POP RDI
    MOV [RDI + minheap.vertPtr], RAX
    MOV RAX, RDI ;MOV the minheap ptr back into RAX
    MOV RSP, RBP
    POP RBP
    RET
    
minheap@insert:
; ----------------------------------------------------------------------------
; Function: Minheap insert.
; Description:
;   Inserts value into min heap.
; Parameters:
;   RDI - (Minheap*)      This.
;   RSI - (long)          Value to insert.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - R11, R12, R13, R15
; ---------------------------------------------------------------------------  
   PUSH RBP   
   MOV RBP, RSP
   SUB RSP, minheap@insert.STACK_INIT
   MOV [RBP - minheap@insert.This], RDI
   MOV [RBP - minheap@insert.index], 0
   MOV [RBP - minheap@insert.operatedIndex], 0
   
   MOV RAX, [RDI + minheap.ptr]
   MOV RDX, [RDI + minheap.size]
   MOV [RAX + RDX*8], RSI ; Inserts value. I seriously cannot believe I forgot I wrote this; that's assembly...
   MOV [RBP - minheap@insert.index], RDX
   .loop:
       ;This whole code here is pretty gross. This is just for while loop conditionals.
       MOV R10, RDX
       DEC R10
       SHR R10, 1
       MOV [RBP - minheap@insert.operatedIndex], R10
       MOV R15, 1 ; Final condition
       MOV R11, [RBP - minheap@insert.This]
       MOV R12, [RBP - minheap@insert.operatedIndex] 
       MOV R11, [RBP - minheap.ptr]
       MOV R12, [R11 - R12*8]
       MOV R13, [RBP - minheap@insert.index]
       MOV R13, [R11 - R13*8]
       MOV R11, 0
       CMP R12, R13
       SETA R11B
       AND R15,R11
       MOV R12, [RBP - minheap@insert.index]
       MOV R11, 0
       CMP R12, R11
       SETA R11B
       AND R15, R11
       CMP R15, 0
       JNA .loop_end
       
       ;Non-conditional code in the while loop:
       MOV R11, [RBP - minheap@insert.index]
       DEC R11
       SHR R11, 1
       MOV R11, [RBP - minheap@insert.index]
       JMP .loop
       
   .loop_end:
   
   ADD RSP, minheap@insert.STACK_INIT
   MOV RSP, RBP
   POP RBP
   RET
       
minheap@delete:
; ----------------------------------------------------------------------------
; Function: Minheap delete
; Description:
;   Deletes a vertex from the minheap. Eek. RDI will hold the pointer for most of the function as I don't wish to juggle a pointer.
; Parameters:
;   RDI - (Minheap*)      This.
;   RSI - (long)          Value to delete.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - ()              None.
;   Clobbers - RBX, RCX, R11, R12, R13, R14, R15.
; ----------------------------------------------------------------------------
    PUSH RBP   
    MOV RBP, RSP
    SUB RSP, minheap@delete.STACK_INIT
    MOV [RBP -  minheap@delete.This], RDI
    MOV [RBP -  minheap@delete.index], 0
    
    MOV RAX, -1 ;Index
    MOV RDX, [RDI]
    MOV RDX, [RDX + minheap.size]
    MOV RCX, 0 ;Loop ctr
    .for_loop:
        MOV R10, [RDI + minheap.ptr]
        MOV R10, [R10 + RCX*8]
        INC RCX
        JNE R10, RSI
        JB .for_loop
        CMP RCX, RDX
        JB .for_loop
    MOV RAX, RCX
    CMP RAX, -1
    JE .end
    MOV [RBP - minheap@delete.index], RAX ; Save Index
    
    MOV RAX, [RDI + minheap.ptr]
    MOV RDX, RSI ;MOV index from RSI into RDX
    MOV R10, [RDI + minheap.size]
    DEC R10
    MOV R10, [RDI + R10*8] ; Get last element.
    MOV QWORD [RAX + RDX], R10
    MOV R15, [RDI + minheap.size]
    MOV R14, [RBP - minheap@delete.index]
    ;Heapify
    .heapify:
        ; R10 = Conditional, R11 = Smallest, R12 = Left Child, R13 = Right Child, R14 = Index, R15 = Minheap size.
        CALL minheap@left
        MOV R12, RAX
        CALL minheap@right
        MOV R13, RAX
        SHL R12, SHIFT_X2
        ADD R12, 1
        SHL R13, SHIFT_X2
        ADD R13, 2
        MOV R11, R14
        
        initilizeRBXRCXMinheap
        MOV RBX, [RBX + minheap.ptr]
        MOV RCX, [RCX + minheap.ptr]
        MOV RBX, [RBX + R12*8]
        MOV RCX, [RCX + R11*8]
        CMP R12, R15
        JA .end
        CMP RBX, RCX
        JA .end
        MOV R11, R12
        initilizeRBXRCXMinheap
        MOV RBX, [RBX + R13*8]
        MOV RCX, [RCX + R11*8]
        CMP R13, R15
        JA .end
        CMP RBX, RCX
        JA .end
        MOV R11, R13
        CMP R11, R14
        JNE .end
        MOV RSI, R14
        MOV RDX, R11
        MOV RDI, [RBP -  minheap@delete.This]
        MOV R8, [RBP -  minheap@delete.This]
        MOV R8, [R8 + minheap.vTable]
        CALL [R8+minheap@swap]
        MOV R14, R11
        MOV [RBP - minheap@delete.index], R14
    .end
        ADD RSP, minheap@delete.STACK_INIT
        MOV RSP, RBP
        POP RBP
        RET
        
minheap@heapify:
       


ezsqrt:
; ----------------------------------------------------------------------------
; Function: Easy Square Root
; Description:
;   Checks if number is perfect square, and also moves the sqrt to a specified pointer.
; Parameters:
;   RDI - (long)          Input value to sqrt.
;   RSI - (long*)         Location to move sqrt to.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          -1 (Input not square).
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
    
    MOV [RSI], RCX
    
    MOV RSP, RBP
    POP RBP
    RET
        

atol:
; ----------------------------------------------------------------------------
; Function: atol (ascii to long)
; Description:
;   Converts ascii string to long value (64 bits).
; Parameters:
;   RDI - (char*)         Pointer to string to convert to integer.
;   RSI - (long)          Strlen.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Long value of string.
; ---------------------------------------------------------------------------

    PUSH RBP
    MOV RBP, RSP
    SUB RSP, atol.STACK_INIT
    MOV QWORD [RBP - atol.ret]
    
    MOV RBX, 10 ;Multiplier
    MOV RCX, 0
    MOV R8B, BYTE [RDI+RCX]
    .operation:
        MOV RAX, QWORD [RBP - atol.ret]
        MUL RBX
        INC RCX
        SUB R8B, '0'
        ADD RAX, R8
        MOV QWORD [RBP - atol.ret], RAX
        CMP RCX, RSI ;Compare counter to Strlen
        JNE .operation
    
    MOV RAX, QWORD [RBP - atol.ret]
    ADD RSP, atol.STACK_INIT
    MOV RSP, RBP
    POP RBP
    RET
    
    
    
global _start

_start:
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, _start.STACK_INIT
    MOV [RBP - _start.minheap], 0
    MOV [RBP - _start.ret], 0
    
    MOV RAX, [RBP + _start.argc]
    CMP RAX, 4 ;Program name + vertices + SRC + DST
    MOV RDI, INVALID_ARGC
    JNE error
    
    ;SRC Parse
    MOV RDI, QWORD [RBP + _start.argv2]
    LEA RSI, [src_dst.src]
    CALL parse_SRC_DST
    CMP RAX, -1
    MOV RDI, INVALID_SRC
    JBE error
    
    ;DST Parse
    MOV RDI, QWORD [RBP + _start.argv3]
    LEA RSI, [src_dst.dst]
    CALL parse_SRC_DST
    CMP RAX, -1
    MOV RDI, INVALID_DST
    JBE error
    
    ;Count commas
    MOV RCX, 0
    MOV RSI, [RBP+_start.argv1]
    MOV RSI, [RSI]
    comma_loop:
        MOV DL, [RSP+RCX*8]
        INC RCX
        .commaJMP:
        ; ---------------------------------------------------------------------------
        ; Valid bytes: ['0'-'9'], 0, ','
        ; ---------------------------------------------------------------------------
        dq .zero
        times 43 dq .error
        dq .comma ; Handle comma
        dq .neg ; Jump to error.
        times 2 dq .error
        times 10 dq .comma ; '0'-'9' 
        times 69 dq .error
        .comma:
            INC [commas]
            JMP comma_loop
        .error:
        MOV RAX, INVALID_NUM_NEG
        MOV RBX, INVALID_CHAR
        CMP DL, '-'
        CMOVE RDI, RAX
        CMOVNE RDI, RBX
        JMP _start.error
        .zero:
            CMP RCX, 0
            MOV RDI, INVALID_NUM_VERTS
            JE error
            INC [commas] ;To get the actual count, as there's one less comma than the amount of connections.
            MOV RAX, [commas]
            MOV [vertice_array.size], RAX
    ;Continued from zero
    ;Mapping memory for the array [vertex][distances].
    MOV RAX, SYS_MMAP
    MOV RDI, [vertice_array.size]
    SHL RDI, SHIFT_X8
    MOV RSI, PROT_READ | PROT_WRITE
    MOV RDX, MAP_SHARED | MAP_ANONYMOUS
    MOV R10, -1
    MOV R8, 0
    SYSCALL
    MOV [vertice_array.ptr], RAX
    ;Mapping memory for distances
    MOV RAX, SYS_MMAP
    MOV RDI, [vertice_array.vertices]
    SHL RDI, SHIFT_X8
    MOV RSI, PROT_READ | PROT_WRITE
    MOV RDX, MAP_SHARED | MAP_ANONYMOUS
    MOV R10, -1
    MOV R8, 0
    SYSCALL
    MOV [vertice_array.dists], RAX
    ;Check if input is square
    MOV RDI, [vertice_array.size]
    LEA RSI, [vertive_array.vertices]
    CALL ezsqrt
    CMP RAX, -1
    MOV RDI, INVALID_NOT_SQUARE
    JE error   
    ;Check if SRC/DST > vertices
    MOV RAX, [src_dst.src]
    MOV RBX, [vertice_array.vertices]
    CMP RAX, RBX
    MOV RDI, INVALID_SRC
    JA error
    MOV RAX, [src_dst.dst]
    CMP RAX, RBX
    MOV RDI, INVALID_DST
    JA error
    
    
    MOV RDI, [vertice_array.vertices]
    CALL minheap@constructor
    MOV [RBP+_start.minheap], RAX
        
        
    MOV RAX, SYS_EXIT
    MOV RDI, EXIT_OK
    SYSCALL
    
error:
    ;Bad inputs JMP here.
    MOV R15, RDI
    
    MOV RAX, SYS_WRITE
    MOV RDI, STDOUT
    MOV RSI, invalid.msg
    MOV RDX, invalid.len
    SYSCALL
        
    MOV RAX, SYS_EXIT
    MOV RDI, R15
    SYSCALL
    
parse_vertices:
    
    
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
;   RAX - (long)          -1 for invalid input.
; ---------------------------------------------------------------------------

    PUSH RBP,
    MOV RBP, RSP
    SUB RSP, parse_SRC_DST.STACK_INIT
    MOV QWORD [RBP - parse_SRC_DST.argv_loc], RDI
    MOV QWORD [RBP - parse_SRC_DST.strlen], 0
    MOV QWORD [RBP - parse_SRC_DST.atol], 0
    ;Check if SRC/DST is empty or not.
    MOV RAX, [RDI]
    MOV AL, BYTE [RAX] ;Pull first piece of data in string
    CMP RAX, EMPTY_INPUT
    JE .error
    
    MOV RCX, 0
    .validate:
    MOV DL, BYTE [RAX+RCX]
    JMP [.jmpTable + RDX*8] 
    .jmpTable:
    ; ---------------------------------------------------------------------------
    ; Valid bytes: ['0'-'9'], 0
    ; ---------------------------------------------------------------------------
        dq .zero
        times 48 dq .error
        times 10 dq .num
        times 69 dq .error
    .cont: 
    MOV RDI, QWORD [RBP - parse_SRC_DST.argv_loc]
    MOV QWORD [RBP - parse_SRC_DST.strlen], RCX
    MOV RSI, RCX
    CALL atol
    MOV QWORD [RBP - parse_SRC_DST.atol], RAX
            
    .zero:
        CMP RCX, 0
        JE .error ;We really shouldn't have empty inputs or reach this state at RCX == 0 at all.
        JNE .cont
    .num:
        INC RCX
        JMP .validate
    
    .error:
        MOV RAX, -1
        ADD RSP, parse_SRC_DST.STACK_INIT
        MOV RSP, RBP
        POP RBP
        RET

dijkstra:
; ----------------------------------------------------------------------------
; Function: dijkstra
; Description:
;   Utilizes Dijkstra's algorithm to find the shortest path to a vertex.
; Parameters:
;   RDI - (char*)         Pointer to stack location of src/dst.
;   RSI - (long*)         Pointer to src/dst storage in .data
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (long)          Distance.
; ---------------------------------------------------------------------------
    PUSH RBP,
    MOV RBP, RSP
    SUB [RBP - dijkstra.STACK_INIT]
    MOV [RBP - dijkstra.distance]
    ;Initialize distance array
    MOV RCX, 0
    MOV RBX, 0
    MOV RAX, [vertice_array.ptr]
    MOV RDX, [vertice_array.ptr]
    PREFETCH0 RDX ; Operating on memory a lot so I'd like to try and cache this.
    .RCX_loop:
    MOV RDX, [vertice_array.ptr + RCX*8]
    .RBX_loop:
        MOV [RDX+RBX*8], -1
        INC RBX
        CMP RBX, [vertice_array.vertices]
        JB .RBX_loop
        ADD RCX, [vertice_array.vertices]
        CMP RCX, [vertice_array.size]
        JB .RCX_loop
    MOV RAX, 
        
    
        
    
        
        

