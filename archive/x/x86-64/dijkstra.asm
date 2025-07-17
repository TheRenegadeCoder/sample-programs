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

;Stack displacements

%DEFINE _start.STACK_INIT 32
%DEFINE _start.argc 8
%DEFINE _start.argv0 16
%DEFINE _start.argv1 24
%DEFINE _start.argv2 32
%DEFINE _start.argv3 40
; RBP+ ^
; RBP- v    



%DEFINE parse_SRC_DST.STACK_INIT 8
%DEFINE parse_SRC_DST.atol 0


%DEFINE atol.STACK_INIT 8
%DEFINE atol.returnValue 8

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
    .max_size dd 0 ;SYS_MMAP will be based on this value; maximum array size.
section .bss

section .text

global _start

atol:
; ----------------------------------------------------------------------------
; Function: atol (ascii to long)
; Description:
;   Converts ascii string to long value (64 bits).
; Parameters:
;   RDI - (char*)         Pointer to string to convert to integer.
;   RSI - ()              Unused.
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

    PUSH RBP,
    MOV RBP, RSP
    SUB RSP, parse_SRC_DST.STACK_INIT
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

    

