;I/0
%DEFINE SYS_WRITE 1
%DEFINE STDOUT 1

;Memory
%DEFINE SYS_MMAP 9
;PROTS (RDX)
%DEFINE PROT_READ 0x01
%DEFINE PROT_WRITE 0x02
;FLAGS (R10)
%DEFINE MAP_PRIVATE 0x02
%DEFINE MAP_ANONYMOUS 0x20

%DEFINE SYS_MUNMAP 11


;Process
%DEFINE SYS_EXIT 60

section .data

section .rodata

    empty:
        .txt db '\'', 0xA
        .len equ $- empty.txt

    quote db '\''
    
    
section .text


global strlen
strlen:
; ----------------------------------------------------------------------------
; Function: strlen
; Description:
;   Finds the length of the string. Will count until it hits a zero byte. Could be vectorized or optimized in another way but will be left this way for simplicity.
; Parameters:
;   RDI - (char*)         String pointer.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (int)           String length.
; ----------------------------------------------------------------------------
    
    MOV RCX, 0 ;RCX will be our counter.

    .loop:
        CMP BYTE [RDI+RCX], 0 ;Compare character to zero
        JE .done
        INC RCX ;Doesn't disturb any flags
        JNZ .loop ;Short jump back to the .loop label
    .done:
    MOV RAX, RCX
    RET
    
global reverseString
reverseString:
; ----------------------------------------------------------------------------
; Function: strlen
; Description:
;   Reverses a string and returns the pointer to it. Could be vectorized or optimized another way but will be left this way for simplicity.
; Parameters:
;   RDI - (char*)         String pointer.
;   RSI - (int)           String length.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - (char*)         Pointer to reversed string.
; ----------------------------------------------------------------------------  
    %DEFINE reverseString.STACK_INIT 8
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, reverseString.STACK_INIT
    
    MOV [RBP-8], RDI ;Move the string pointer to the stack.    
    
    MOV RAX, SYS_MMAP
    MOV RDI, 0 ;Let the OS decide which address to use.
    MOV RSI, RSI ;Redundant, but RSI will hold how many bytes to allocate.
    MOV RDX, PROT_WRITE | PROT_READ ;We'll allow the memory to be read and written to.
    MOV R10, MAP_PRIVATE | MAP_ANONYMOUS ;We won't allow other processes to touch this memory, and it will not be associated with a file.
    MOV R8, 0 ;No file descriptor.
    MOV R9, 0 ;No offset.
    SYSCALL
    
    MOV RDI, RAX ;RDI (destination register) will hold our new string pointer.
    MOV RBX, RSI ;RBX (base register) will hold the end address.
    DEC RBX
    MOV RSI, [RBP-8] ;RSI (source register) will hold the old string address.
    MOV RCX, 0 ;RCX (counter register) will hold the loop counter.
    ;Address calculations
    ADD RSI, RBX
    .loop:
        MOV AL, [RSI] ;Move char from location RSI to AL
        MOV [RDI+RCX], AL ;Move char from AL to location pointer to at RDI+RCX
        ;Adding to counter and shifting pointers.
        INC RSI
        DEC RSI
        CMP RCX, RBX
        JBE .loop
        
    POP RAX ;Equivalent to MOV RAX, [RBP-8] (dependant on stack size) ADD RSP, 8
    MOV RAX, RDI ;Move the new string pointer into RAX for returning.
    MOV RSP, RBP
    POP RBP
    RET

global _start
_start:
    %DEFINE _start.STACK_INIT 16 ;Defining this so we aren't placing a literal every time we need to empty the stack at the end.
    ;Setting up stack frame. Prolog.
    PUSH RBP
    MOV RBP, RSP
    ;Allocating space on the stack for variables
    SUB RSP, _start.STACK_INIT ;16 bytes allocated
    MOV QWORD [RBP-8], 0 ;Length of text, 8 bytes.
    MOV QWORD [RBP-16], 0 ;New String PTR, 8 bytes.

    MOV RAX, [RBP+8] ;Move argc from stack to RAX.
    JMP [argcDispatch+RAX*8]
    
    argcDispatch:
    ;Jump table
        dq noInput ;argcDispatch+0*8
        dq input ;argcDispatch+1*8
    
    noInput:
        ;Print empty string
        MOV RAX, SYS_WRITE
        MOV RDI, STDOUT
        MOV RSI, empty.txt
        MOV RDX, empty.len
        SYSCALL

        ;Epilog
        ADD RSP, _start.STACK_INIT
        MOV RSP, RBP
        POP RBP

        ;Exit
        MOV RAX, SYS_EXIT
        XOR RDI, RDI
        SYSCALL
        
    input:
        MOV RAX, [RBP+16] ;MOV arg1 to RAX
        CALL strlen ;Call our string length function

        MOV [RBP-8], RAX ;Move string length result into RSP-8

        MOV RDI, [RBP+16]
        MOV RSI, RAX
        CALL reverseString
        MOV [RBP-16], RAX ;Moving return pointer into RBP-16

        MOV RAX, SYS_WRITE
        MOV RDI, STDOUT
        MOV RSI, [RBP-16] ;Moving string pointer into RSI
        MOV RDX, [RBP-8] ;Moving string length into RDX
        SYSCALL

        ;Equivalent to *reversedString = NULL; in C
        MOV RAX, SYS_MUNMAP
        MOV RDI, [RBP-16] ;Move string pointer into RDI to be unmapped.
        MOV RSI, [RBP-8] ;Move amount of memory to be unmapped in bytes.
        SYSCALL

        ;Epilog
        ADD RSP, _start.STACK_INIT
        MOV RSP, RBP
        POP RBP

        ;Exit
        MOV RAX, SYS_EXIT
        XOR RDI, RDI
        SYSCALL
    
    
