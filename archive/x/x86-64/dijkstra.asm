;Exit codes
%DEFINE EXIT_OK 0
%DEFINE INVALID_ARGC -1
%DEFINE INVALID_SRC -2
%DEFINE INVALID_SRC -3
%DEFINE INVALID_NUM_NEG -4
%DEFINE INVALID_CHAR -5

;Constants
%DEFINE EMPTY_INPUT 0


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

%DEFINE _start.STACK_INIT 32
%DEFINE _start.argc 8
%DEFINE _start.argv0 16
%DEFINE _start.argv1 24
%DEFINE _start.argv2 32
%DEFINE _start.argv3 40
; RBP+ ^
; RBP- v    



%DEFINE parse_SRC_DST.STACK_INIT 16
%DEFINE parse_SRC_DST.argv_loc 8
%DEFINE parse_SRC_DST.strlen 16
%DEFINE parse_SRC_DST.atol 24


%DEFINE atol.STACK_INIT 8
%DEFINE atol.ret 8

section .rodata

invalid:
    .msg db 'Usage: please provide three inputs: a serialized matrix, a source node and a destination node'
    .len equ $- .msg


section .data

src_dst:
    .src dq 0
    .dst dq 0  
minheap:
    ;Minheap will be used to implement priority queue.
    .ptr dq 0
    .size dd 0
    .max_size dd 0 ;SYS_MMAP will be based on this value; maximum array size.

commas dq 0
section .bss

section .text

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
;   RAX - long value of string.
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
    
    MOV RAX, [RBP + _start.argc]
    CMP RAX, 4 ;Program name + vertices + SRC + DST
    MOV RDI, INVALID_ARGC
    JNE .error
    
    ;SRC Parse
    MOV RDI, QWORD [RBP + _start.argv2]
    LEA RSI, [src_dst.src]
    CALL parse_SRC_DST
    CMP RAX, -1
    MOV RDI, INVALID_SRC
    JBE .error
    
    ;DST Parse
    MOV RDI, QWORD [RBP + _start.argv3]
    LEA RSI, [src_dst.dst]
    CALL parse_SRC_DST
    CMP RAX, -1
    MOV RDI, INVALID_DST
    JBE .error
    
    ;Count commas
    MOV RCX, 0
    MOV RSI, [RBP+_start.argv1]
    MOV RSI, [RSI]
    comma_loop:
        MOV DL, [RSP+RCX]
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
        
        
    MOV RAX, SYS_EXIT
    MOV RDI, EXIT_OK
    SYSCALL
    
    .error:
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
;   RAX - -1 for invalid input.
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

    

