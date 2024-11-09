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

%DEFINE PROT_READ 0x01
%DEFINE PROT_WRITE 0x02

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
    %DEFINE reverseString.STACK_INIT 8
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, reverseString.STACK_INIT ;Reserve space for string pointer, so we can use RAX (accumulator).
    ;RAX pointer of string to be reversed
    ;RDI String length

    ;Moving the string pointer input to the stack.
    MOV [RBP-8], RAX

    MOV RAX, SYS_MMAP
    MOV RSI, RDI ;Allocate the same amount of memory that the string takes.
    MOV RDI, 0 ;Let the OS decide which address to use
    MOV RDX, PROT_WRITE | PROT_READ ;We'll allow the memory to be read and written to.
    MOV R10, MAP_PRIVATE | MAP_ANONYMOUS ;We won't allow other processes to touch this memory, and it will not be associated with a file.
    MOV R8, 0 ;No file descriptor.
    MOV R9, 0 ;No offset.
    SYSCALL
    ;RDI will be the pointer to the new memory mapped string.
    MOV RDI, RAX 
    ;AL will be the character register.
    MOV RAX, 0
    ;RBX will be the pointer offset AND string length.
    MOV RBX, RSI ;RBX now holds the string length.
    ;RSI will hold the string address.
    MOV RSI, [RBP-8]
    LEA RSI, [RSI+RBX-1] ;Pointer arithmetic; points to the end of the string.
    ;RCX will be our counter.
    MOV RCX, 0
    .loop:
        MOV AL, [RSI-RCX] ;Move char from location pointed at RSI-RCX to AL
        MOV [RDI+RCX], AL ;Move char from AL to location pointed at RDI+RCX
        INC RCX ;Increase loop counter
        CMP RCX, RBX
        JL reverseString.loop ;Jump short if lower than RBX (string length)

    POP RAX ;Equivlant to MOV RAX, [RBP-8] ADD RSP, 8
    ;Return: Pointer of reversed string.
    MOV RSP, RBP
    POP RBP

_start:
    %DEFINE _start.STACK_INIT 16 ;Defining this so we aren't placing a literal every time we need to empty the stack at the end.
    ;Setting up stack frame. Prolog.
    PUSH RBP
    MOV RBP, RSP
    ;Allocating space on the stack for variables
    SUB RSP, _start.STACK_INIT ;16 bytes allocated
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




    

    




