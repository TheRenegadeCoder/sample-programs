; SYSCALLS
%DEFINE SYS_READ 0

%DEFINE SYS_WRITE 1
%DEFINE STDOUT 1


%DEFINE SYS_OPEN 2
%DEFINE RDONLY 0x0
%DEFINE NO_MODE 0
%DEFINE SYS_CLOSE 3

%DEFINE SYS_FSTAT 5

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

%DEFINE SYS_EXIT 60

; CONSTS
%DEFINE TERM_STRING 0
%DEFINE EXIT_OK 0

; STACKS

%DEFINE _start.STACK_INIT 32
%DEFINE _start.QUINE_FD 8
%DEFINE _start.FSTAT_PTR 16
%DEFINE _start.QUINE_BUF 24

section .rodata
struc stat
    .st_dev resq 1
    .st_ino resq 1
    .st_nlink resq 1
    .st_mode resd 1
    .st_uid resd 1
    .st_gid resd 1
    .padding0 resd 1
    .st_rdev resq 1
    .st_size resq 1
    .st_blksize resq 1
    .st_blocks resq 1
    .st_atime resq 1
    .st_atime_nsec resq 1
    .st_mtim resq 1
    .st_mtim_nsec resq 1
    .st_ctim resq 1
    .st_ctim_nsec resq 1
    .unused resq 1
endstruc

filename db 'quine.asm', TERM_STRING
section .data

section .bss

section .text

global _start

_start:
PUSH RBP
MOV RBP, RSP
SUB RSP, _start.STACK_INIT

MOV RAX, SYS_OPEN
MOV RDI, filename
MOV RSI, RDONLY
MOV RDX, NO_MODE
SYSCALL
MOV [RBP - _start.QUINE_FD], RAX

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, stat_size
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - _start.FSTAT_PTR], RAX

MOV RAX, SYS_FSTAT
MOV RDI, [RBP - _start.QUINE_FD]
MOV RSI, [RBP - _start.FSTAT_PTR]
SYSCALL
MOV R12, [RBP - _start.FSTAT_PTR]

MOV RAX, SYS_MMAP
MOV RDI, NO_ADDR
MOV RSI, [R12 + stat.st_size]
MOV RDX, PROT_READ | PROT_WRITE
MOV R10, MAP_SHARED | MAP_ANONYMOUS
MOV R8, NO_FD
MOV R9, NO_OFFSET
SYSCALL
MOV [RBP - _start.QUINE_BUF], RAX

MOV RAX, SYS_READ
MOV RDI, [RBP - _start.QUINE_FD]
MOV RSI, [RBP - _start.QUINE_BUF]
MOV RDX, [R12 + stat.st_size]
SYSCALL

MOV RAX, SYS_WRITE
MOV RDI, STDOUT
MOV RSI, [RBP - _start.QUINE_BUF]
MOV RDX, [R12 + stat.st_size]
SYSCALL

MOV RAX, SYS_CLOSE
MOV RDI, [RBP - _start.QUINE_FD]
SYSCALL

MOV RAX, SYS_MUNMAP
MOV RDI, [RBP - _start.QUINE_BUF]
MOV RSI, [R12 + stat.st_size]
SYSCALL

MOV RAX, SYS_MUNMAP
MOV RDI, [RBP - _start.FSTAT_PTR]
MOV RSI, stat_size
SYSCALL

MOV RAX, SYS_EXIT
MOV RDI, EXIT_OK
SYSCALL
