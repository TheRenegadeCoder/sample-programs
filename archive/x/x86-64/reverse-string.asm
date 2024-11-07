;I/0
%DEFINE SYS_READ 0
%DEFINE STDIN 0
%DEFINE SYS_WRITE 1
%DEFINE STDOUT 1

;Memory
%DEFINE SYS_MMAP 9
;PROTS (RDX)

;Process
%DEFINE SYS_EXIT 60

%DEFINE PROT_NONE 0x00
%DEFINE PROT_READ 0x01
%DEFINE PROT_WRITE 0x02
%DEFINE PROT_EXEC 0x04

;FLAGS (R10)
%DEFINE MAP_PRIVATE 0x02
%DEFINE MAP_ANONYMOUS 0x20


%DEFINE SYS_MUNMAP 11


section .data

section .rodata

    empty:
        .txt db '', 0xA
        .len equ $- empty.txt

section .text

global strlen
strlen:
    ;Could be vectorized or have other optimization techniques applied but will be simplified for here.

    ;RAX = String ptr.

    MOV RSI, RAX ;Moving our string pointer into our source register.
    MOV RAX, 0 ;Clearing RAX 
    MOV RCX, 0 ;RCX will be our counter.

    .loop:
        CMP BYTE [RSI+RCX], 0 ;Compare character to zero
        INC RCX ;Doesn't disturb any flags
        CMOVA RAX, RCX ;Move RCX into RAX if character > 0
        JA .loop ;Short jump back to the .loop label
    ;Return = String length.
    RET


global reverseString
reverseString:
    ;RAX pointer of string to be reversed

_start:
    %DEFINE STACK_INIT 16 ;Defining this so we aren't placing a literal every time we need to empty the stack at the end.
    ;Setting up stack frame. Prolog.
    PUSH RBP
    MOV RBP, RSP
    ;Allocating space on the stack for variables
    SUB RSP, STACK_INIT ;16 bytes allocated
    MOV [RBP-8], 0 ;Length of text, 8 bytes.
    MOV [RBP-16], 0 ;New String PTR, 8 bytes.
    
    MOV RAX, [RBP+8]
    JMP [argcDispatch+RAX*8]
    

    argcDispatch:
        ;No contingencies are listed for more than one string input.
        ;Points to noInput if argc at RSP+8 is zero, or input if it's one.
        dq noInput
        dq input


    noInput:
        ;Print empty string
        MOV RAX, SYS_WRITE
        MOV RDI, STDOUT
        MOV RSI, empty.txt
        MOV RDX, empty.len
        SYSCALL

        ;Epilog
        ADD RSP, STACK_INIT
        MOV RSP, RBP
        POP RBP

        ;Exit
        MOV RAX, SYS_EXIT
        XOR RDI, RDI
        SYSCALL


    

    




