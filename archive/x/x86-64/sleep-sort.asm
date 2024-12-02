%MACRO POPREGS 0
POP R9
POP R8
POP R10
POP RSI
POP RDI
POP RDX
POP RCX
POP RBX
POP RAX
%ENDMACRO
%MACRO PUSHREGS 0
PUSH RAX
PUSH RBX
PUSH RCX
PUSH RDX
PUSH RDI
PUSH RSI
PUSH R10
PUSH R8
PUSH R9
%ENDMACRO
%MACRO SLEEP 0
MOV RAX, SYS_NANOWAIT
MOV RDI, timespec
MOV RSI, 0
SYSCALL
%ENDMACRO


;I/O
%DEFINE SYS_WRITE 1
%DEFINE STDOUT 1

;Signals
%DEFINE SYS_RT_SIGACTION 13
%DEFINE SIGCHLD 17
%DEFINE SIG_IGN 0x01 ;Ignore signal so we don't need to use a signal handler.
%DEFINE SIGSETSIZE 8
;Flags
%DEFINE SA_NOCLDWAIT 0x02 ;Reap child processes automatically.

;Memory
%DEFINE SYS_MMAP 9
;PROTS (RDX)
%DEFINE PROT_READ 0x01
%DEFINE PROT_WRITE 0x02
;FLAGS (R10)
%DEFINE MAP_SHARED 0x01
%DEFINE MAP_ANONYMOUS 0x20

%DEFINE SYS_MUNMAP 11

;Processes
%DEFINE SYS_NANOWAIT 35
%DEFINE SYS_CLONE 56
;Flags
%DEFINE CLONE_VM 0x0100
%DEFINE CLONE_SIGHAND 0x0800
%DEFINE CLONE_THREAD 0x00010000
%DEFINE CLONE_SETTLS 0x00080000

%DEFINE SYS_EXIT 60
%DEFINE SYS_KILL 62
%DEFINE SIGTERM 0x15

%DEFINE SYS_ARCH_PRCTL 158
%DEFINE ARCH_SET_FS 0x1002
%DEFINE ARCH_GET_FS 0x1003

%DEFINE SYS_GETTID 186

%DEFINE SYS_FUTEX 202
%DEFINE FUTEX_WAIT 0
%DEFINE FUTEX_WAKE 1

%DEFINE SYS_KILL 62
%DEFINE SYS_TGKILL 234


;_start function definitions
%DEFINE _start.STACK_INIT 32
%DEFINE _start.argc 8
%DEFINE _start.argv0 16
%DEFINE _start.argv1 24
; RBP+ ^
; RBP- v    
%DEFINE _start.SEMAPHORE 0
%DEFINE _start.threadLock 8
%DEFINE _start.threadLock.MUTEX 0
%DEFINE _start.threadCount 16
%DEFINE _start.PID 24

;FSM function definitions
%DEFINE FSM.STACK_INIT 40
%DEFINE FSM.threadValue 8
%DEFINE FSM.numPtr 16
%DEFINE FSM.numLen 24
%DEFINE FSM.threadTID 32
%DEFINE FSM.threadTLSPtr 40
    
%DEFINE threadTLS.size 56 ; Each 
%DEFINE threadTLS.ptr 0
%DEFINE threadTLS.timespec 8
%DEFINE threadTLS.timespec.seconds 8
%DEFINE threadTLS.timespec.nanoseconds 16
%DEFINE threadTLS.numLen 24
%DEFINE threadTLS.numPtr 32
%DEFINE threadTLS.sleepTime 40
%DEFINE threadTLS.TID 48

%DEFINE INT_MAX 2147483647
%DEFINE THREAD_LIMIT 32 ;32 threads seems reasonable.


section .data
    parentStackBase dq 0 ; I was trying to use R12 to hold the pointer to _start's RBP but I don't think a register should be squatted on for that long. RBP is a lot better because it's static inside the current function.
    align 16, db 0
    MUTEX dq 0
    printMUTEX dq 0
    spawnMUTEX dq 0
    threadCount dq 0
    argc dq 0
    stringAddress dq 0
section .rodata
errorMsg:
    .txt db 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"', 0xA
    .len equ $- .txt

main_sigAction:
    .sa_handler dq SIG_IGN
    .sa_mask times 128 db 0
    .sa_flags dd SA_NOCLDWAIT
    .padding dd 0
    .sa_restorer dq 0

timespec:
    %DEFINE timespec.seconds 0
    %DEFINE timespec.nanoseconds 8
    ;Placing this here so we know how the timespec struct is laid out in memory and to add delays so the container doesn't mess up our timings.
    .seconds dq 0
    .nanoseconds dq 500
    
    
commaSpace:
    .txt db ', '
    .len equ $- .txt
    
creation:
    .txt db 'Thread Spawned',0xA
    .len equ $- .txt

section .text
; ----------------------------------------------------------------------------
; Function: incThreadCount/decThreadCount/readThreadCount
; Description:
;   Made to ensure atomicity of threadCount in .data across all threads and atomicity of its usage in all threads.
;   A container for increasing/reading threadCount.
; Parameters:
;   RDI - ()              Unused.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - None for incThreadCount/decThreadCount, as RAX is just clobbered. threadCount value for readThreadCount as threadCount is stored in RAX.
; ---------------------------------------------------------------------------
incThreadCount:
    LEA RAX, [threadCount]
    LOCK INC QWORD [RAX]
    MFENCE
    RET
decThreadCount:
    LEA RAX, [threadCount]
    LOCK DEC QWORD [RAX]
    MFENCE
    RET
readThreadCount:
    MFENCE
    LEA RAX, [threadCount]
    MOV RAX, QWORD [RAX]
    LFENCE
    RET
; ----------------------------------------------------------------------------
; Function: initializeTLS
; Description:
;   Initializes TLS for new thread.
;   This function does not have a stack frame setup.
;   TO ONLY BE CALLED FROM FSM.
; Parameters:
;   RDI - (void*)         Base ptr to parent stack frame.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - TLS pointer.
; ---------------------------------------------------------------------------
initializeTLS:
    PUSH RDI
    MOV RAX, SYS_MMAP
    MOV RDI, 0 ; No address hint.
    MOV RSI, threadTLS.size ; Size of TLS buffer.
    MOV RDX, PROT_READ | PROT_WRITE ; We can read and write to this section of memory.
    MOV R10, MAP_SHARED | MAP_ANONYMOUS ; Share memory across processes and don't map to a file.
    MOV R8, -1 ; No file descriptor.
    MOV R9, 0 ; No offset.
    SYSCALL
    POP RDI
    
    MOV RSI, RDI ; RS(ource)I(ndex) will hold our source (Base ptr to stack frame) instead of RD(estination)I(ndex), where our destination register will hold the TLS pointer.
    
    MOV [RSI - FSM.threadTLSPtr], RAX
    MOV RDI, RAX ; RDI will hold the pointer to our TLS for now.
    MOV RDX, 0 ; RDX will hold the data to place into the TLS buffer.
    MOV [RAX], RAX ; Move the pointer to the TLS into TLS[0]. I LOVE MOVs like these.
    MOV RDX, [RSI - FSM.threadValue]
    MOV [RDI + threadTLS.sleepTime], RDX
    MOV [RDI + threadTLS.timespec.seconds], RDX
    MOV RDX, [RSI - FSM.numLen]
    MOV [RDI + threadTLS.numLen], RDX
    MOV RDX, [RSI - FSM.numPtr]
    MOV RDX, [RDX]
    MOV [RDI + threadTLS.numPtr], RDX
    MFENCE ; Allow all of these load and store operations to occur before any others afterwards do.
    
    MOV RAX, RDI
    RET
; ----------------------------------------------------------------------------
; Function: sleep_thread
; Description:
;   The FSM function calls this when wanting to create a thread, then stays here if the child, or RETs back when the parent thread, then uses nanosleep to wait n seconds to print.
;   FSM will unlock the FUTEX making the cloned threads sleep once all of the threads are created, synchronizing the nanosleep times.
;   Printing is locked through a spinlock when a thread is printing its value to avoid printing "race conditions". Uses TLS through the FS segment to address variables related to the spawned thread.
;   Afterwards, it cleans up its own memory and runs SYS_KILL on itself.
; Parameters:
;   RDI - (void*)         Pointer to allocated TLS memory to set FS base to.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - None.
; ---------------------------------------------------------------------------
sleep_thread:
    PUSH RDI
    
    ;Spawn sleep thread.
    MOV RAX, SYS_CLONE
    MOV R10, RDI ; Move TLS pointer to R10.
    MOV RDI, CLONE_VM | CLONE_SIGHAND | CLONE_SETTLS | CLONE_THREAD ; Share virtual memory with parent, share signal handlers, allow TLS to be set through the system call, and a new thread..
    MOV RSI, 0 ; No new stack.
    MOV RDX, 0 ; No parent TID.
    MOV R10, 0 ; No child TID.
    MOV R8, 0 ; No child TLS ptr.
    SYSCALL
    
    ; If RAX == 0, then it is the child thread, and we can continue here. If not, RET back to FSM as the thread is the parent thread.
    CMP RAX, 0
    JZ .thread
    ADD RSP, 8 ; Clear out stack frame for here.
    RET
    .thread:
    
        ;MOV R11, [parentStackBase] ; Move parent RBP to R11 here.
        ;SFENCE
        ;LOCK INC QWORD [R11 - _start.threadCount] ; Locking here just for safety, any race condition would deadlock _start.
        ;MOV R13, [R11 - _start.threadCount]
        POP RDI
        MOV RAX, SYS_ARCH_PRCTL
        MOV RDI, ARCH_SET_FS
        MOV RSI, R13
        SYSCALL
        ;We can now dereference items in the TLS through [FS:n] now.
        MOV RAX, SYS_GETTID
        SYSCALL
        MOV [FS:threadTLS.TID], RAX
        CALL incThreadCount
        ;Make thread wait on the lock at RBP[-_start.threadLock] in _start.
        MOV RAX, SYS_FUTEX
        MOV RDI, MUTEX
        MOV RSI, FUTEX_WAIT
        MOV RDX, _start.threadLock.MUTEX ; Wake up when the X location in RDI dereferences to zero (WAKE)
        MOV R10, 0 ; No timeout.
        MOV R8, 0 ; No requeue
        MOV R9, 0 ; Unused for this.
        SYSCALL
        block: ;Here for GDB purposes.
        ;Sleep for n seconds.
        MOV RAX, SYS_NANOWAIT
        MOV RDI, [FS:threadTLS.ptr]
        ADD RDI, threadTLS.timespec.seconds
        MOV RSI, 0 ; We don't care about remaining time.
        SYSCALL
        ;Lock printing.
        getPrintLock:
        MOV R15, 1
        getPrintLockRetry:
        XCHG R15, [printMUTEX]
        TEST R15, R15
        JE printLockObtained
        MOV RAX, SYS_FUTEX
        MOV RDI, printMUTEX
        MOV RSI, FUTEX_WAIT
        MOV RDX, 0 ; Wake up when the memory location in RDI dereferences to zero (WAKE)
        MOV R10, 0 ; No timeout.
        MOV R8, 0 ; No requeue
        MOV R9, 0 ; Unused for this.
        SYSCALL
        JMP getPrintLockRetry
        printLockObtained:
        ; Print number
        MOV RAX, SYS_WRITE
        MOV RDI, STDOUT
        MOV RSI, [FS:0]
        ADD RSI, threadTLS.numPtr ; Move pointer to numPtr in the TLS.
        MOV RDX, [FS:threadTLS.numLen]
        SYSCALL
        
        ; If not the last thread, print comma, then fall through to .kill, if it is the last thread, jump to .kill
        CALL readThreadCount
        CMP RAX, 1
        JE .kill
        MOV RAX, SYS_WRITE
        MOV RDI, STDOUT
        MOV RSI, commaSpace.txt
        MOV RDX, commaSpace.len
        SYSCALL
        .kill:
            ;Unlock printing.
            MOV R15, 0
            XCHG R15, [printMUTEX]
            MOV RAX, SYS_FUTEX
            MOV RDI, printMUTEX
            MOV RSI, FUTEX_WAKE
            MOV RDX, INT_MAX
            MOV R10, 0 ; No timeout.
            MOV R8, 0 ; No requeue.
            MOV R9, 0 ; Unused.
            SYSCALL
            
            PUSH QWORD [FS:threadTLS.TID] ; Store TID
            MOV RAX, SYS_MUNMAP
            MOV RDI, [FS:threadTLS.ptr]
            MOV RSI, threadTLS.size
            SYSCALL
            
            MOV RAX, [parentStackBase]
            LOCK INC QWORD [RAX - _start.SEMAPHORE]
            CALL decThreadCount
            
            MOV RAX, SYS_EXIT
            POP RDI
            SYSCALL
        
        
    
    
global stringToInt
stringToInt:
; ----------------------------------------------------------------------------
; Function: stringToInt
; Description:
;   Takes a pointer to an integer string (comma or null terminated), and returns the string as an integer. I chose 32 bit registers because I only want a 64 bit result; no high or low part.
; Parameters:
;   RDI - (char*)         String address.
;   RSI - (char*)         End string address.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - The integer string converted into an integer.
; ----------------------------------------------------------------------------
    MOV RAX, 0 ;AL will store the character, for multiplication operation.
    MOV RBX, 1 ;EBX will store the multiplier.
    MOV RCX, RSI ;RCX will be the counter.
    DEC RCX
    MOV R9, 0 ;R9 will be used to store the return number temporarily.
    
    .loop:
        MOV AL, [RCX]
        SUB AL, '0'
        DEC RCX
        IMUL RAX, RBX
        IMUL RBX, 10
        ADD R9, RAX
        CMP RCX, RDI
        JL .done
        JMP .loop
    .done:
        MOV RAX, R9
    RET

global FSM
FSM:
; ----------------------------------------------------------------------------
; Function: FSM
; Description:
;   A finite state machine that iterates over argv[1]. Uses a jump table to dispatch the program to change the state, and/or run specialized tasks such as spawning threads.
;   At the end, it turns on ALL of the created threads so they are synchronized, then spinlocks until they are done "sorting"; afterwards, the function returns a user-specified value in RAX.
; Parameters:
;   RDI - ()              Unused.
;   RSI - ()              Unused.
;   RDX - ()              Unused.
;   R10 - ()              Unused.
;   R8  - ()              Unused.
;   R9  - ()              Unused.
; Returns:
;   RAX - Dynamic while programming for debugging purposes, could be thread count, could be the semaphore, anything. Right now: thread count. Useful for use with the INT3 instruction.
; ----------------------------------------------------------------------------                
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, FSM.STACK_INIT
    MOV QWORD [RBP - FSM.threadValue], 0 ; The sleep time, based on the command line argument.
    MOV QWORD [RBP - FSM.numPtr], 0 ; Pointer to the beginning of the number argument on the command line.
    MOV QWORD [RBP - FSM.numLen], 0 ; Length of the number.
    MOV QWORD [RBP - FSM.threadTID], 0 ; TID to pass to the thread so it can run SYS_KILL on itself; number itself will be passed to thread.
    MOV QWORD [RBP - FSM.threadTLSPtr], 0 ; Pointer to the thread TLS.
    
    MOV RAX, 0 ; The accumulator register will hold any return value.
    MOV RBX, [stringAddress] ; The base register will hold the starting address of the number
    MOV RCX, 0 ; The counter register will hold the loop counter.
    MOV RDX, 0 ; The data register will hold the character.
    MOV RSI, [stringAddress] ; The source register will hold the parent stack base pointer argv[1] string to be dereferenced from.
    MOV R13, 0 ; R13 will hold the TLS pointer temporarily for calling sleep_thread.
    
    ;Initial checking if argv[1] is empty or not. Check if argument == "", on top of not allowing any non-number argument.
    MOV DL, [RSI+RCX]
    CMP DL, '0'
    JL .error
    CMP DL, '9'
    JA .error
    LEA RBX, [RSI] ; Move beginning pointer to RBX.
    MOV [RBP - FSM.numPtr], RBX ; Move beginning pointer to RBP - FSM.numPtr
    
    .loop:
        JMP [.jmpTable + RDX*8]
    .jmpTable:
        dq .zero ; Jump to .zero label if DL is a null character (terminator).
        times 31 dq .error
        dq .space ;Jump to .space label if DL is a space character.
        times 11 dq .error
        dq .comma ; Jump to .comma label if DL is a comma character.
        times 3 dq .error
        times 10 dq .num ; Jump to .num label if DL is 0-9
        times 69 dq .error
     .num:
        INC RCX ; Increase counter by one.
        INC QWORD [RBP - FSM.numLen] ; Increase number length by one.
        MOV DL, [RSI+RCX] ; Move new character into DL.
        CMP DL, ' '
        JE .error
        JMP [.jmpTable +RDX*8] ; Jump back to the jump table.
     .comma:
        ;This will spawn the threads.
        PUSHREGS
        CALL readThreadCount
        CMP RAX, THREAD_LIMIT
        JE .cutComma
        LOCK INC QWORD [argc]
        POPREGS
        PUSHREGS
        MOV RDI, RBX
        MOV RSI, [stringAddress]
        LEA RSI, [RSI+RCX]
        CALL stringToInt
        MOV [RBP - FSM.threadValue], RAX
        POPREGS
        
        PUSHREGS
        MOV RDI, RBP
        CALL initializeTLS
        MOV R13, RAX
        POPREGS
        ; Clear out the stack
        MOV QWORD [RBP - FSM.threadValue ], 0 ;The sleep time, based on the command line argument.
        MOV QWORD [RBP - FSM.numPtr ], 0 ;Pointer to the beginning of the number argument on the command line.
        MOV QWORD [RBP - FSM.numLen ], 0 ;Length of the number.
        MOV QWORD [RBP - FSM.threadTID ], 0 ;TID to pass to the thread so it can run SYS_KILL on itself; number itself will be passed to thread.
        MOV QWORD [RBP - FSM.threadTLSPtr ], 0 ;Pointer to the thread TLS.
        SFENCE ;Allow all of these store operations to occur before others can happen.
        
        ;Spawn child thread.
        PUSHREGS
        MOV RDI, R13
        CALL sleep_thread
        SLEEP
        POPREGS
        ;FSM iteration
        .cutComma:
        INC RCX
        MOV DL, [RSI+RCX]
        JMP [.jmpTable +RDX*8]
        
        .space:
        MOV QWORD [RBP - FSM.numLen], 0 ; Clear number length.
        INC RCX ; Increase counter by one.
        LEA RBX, [RSI+RCX] ; Load effective address of RSI + RCX (offset) as new beginning of number ptr.
        MOV [RBP - FSM.numPtr], RBX
        MOV DL, [RSI+RCX] ; Move new character into DL.
        JMP [.jmpTable +RDX*8] ; Jump back to the jump table.
        
        .zero:
        ;Making sure we don't have inputs like just "1". If there hasn't been a comma yet, then _start.threadCount will be zero.
        CALL readThreadCount
        CMP RAX, 0
        JE .error
        ;This will signal the end of the finite state machine, add the last thread, signal the threads to wake up, and move the control flow to threadManagment.
        ;This will spawn the threads.
        PUSHREGS
        CALL readThreadCount
        CMP RAX, THREAD_LIMIT
        JE .cutZero
        POPREGS
        PUSHREGS
        LOCK INC QWORD [argc]
        MOV RDI, RBX
        MOV RSI, [stringAddress]
        LEA RSI, [RSI+RCX]
        CALL stringToInt
        MOV [RBP - FSM.threadValue], RAX
        POPREGS
        
        PUSHREGS
        LEA RDI, [RBP]
        CALL initializeTLS
        MOV R13, RAX
        POPREGS
        ; Clear out the stack
        MOV R14, [RBP - FSM.threadValue] ;For debugging.
        MOV QWORD [RBP - FSM.threadValue ], 0 ;The sleep time, based on the command line argument.
        MOV QWORD [RBP - FSM.numPtr ], 0 ;Pointer to the beginning of the number argument on the command line.
        MOV QWORD [RBP - FSM.numLen ], 0 ;Length of the number.
        MOV QWORD [RBP - FSM.threadTID ], 0 ;TID to pass to the thread so it can run SYS_KILL on itself; number itself will be passed to thread.
        MOV QWORD [RBP - FSM.threadTLSPtr ], 0 ;Pointer to the thread TLS.
        SFENCE ;Allow all of these store operations to occur before others can happen.
        
        ;Spawn child thread.
        PUSHREGS
        MOV RDI, R13
        CALL sleep_thread
        SLEEP
        POPREGS
        .cutZero:
        ;Wait for all threads to finish setup.
        .mainWait:
            .mainLock:
                MFENCE
                CALL readThreadCount
                CMP RAX, [argc]
                JE .mainUnlock
                PAUSE
                JMP .mainLock
        .mainUnlock:    
        ;Wake up threads:
        MOV RAX, SYS_FUTEX
        MOV RDI, MUTEX
        MOV RSI, FUTEX_WAKE
        MOV RDX, INT_MAX
        MOV R10, 0 ; No timeout.
        MOV R8, 0 ; No requeue.
        MOV R9, 0 ; Unused.
        SYSCALL
        
        JMP .threadManagement
        
        .error:
        ADD RSP, FSM.STACK_INIT
        MOV RSP, RBP
        POP RBP
        
        JMP _start.failure
        
        .threadManagement:
            .lock:
                MFENCE ; Wait for all memory ops to finish.
                CALL readThreadCount
                CMP RAX, 0
                JE .unlock
                PAUSE
                JMP .lock
                
        .unlock:
            ADD RSP, FSM.STACK_INIT
            MOV RSP, RBP
            POP RBP
            
            CALL readThreadCount
            RET
                
        
        
        
    
global _start
_start:
    PUSH RBP
    MOV RBP, RSP
    
    MOV [parentStackBase], RBP ;Save base pointer for later. RBP will be addressed though R12 ONLY when we are in another stack frame; we'll only address through RBP in main.
    MOV RAX, [RBP+_start.argv1] ;MOV string pointer into RAX
    MOV [stringAddress], RAX ;Save string pointer.
    
    SUB RSP, _start.STACK_INIT
    MOV QWORD [RBP - _start.SEMAPHORE ], 0 ;Semaphore for when all of the threads are finished, and main can run once again; we'll just spinlock for main.
    MOV QWORD [RBP - _start.threadLock ], _start.threadLock.MUTEX ;Lock so we can wait to start all threads.
    MOV QWORD [RBP - _start.threadCount ], 0 ;Thread count.
    MOV QWORD [RBP - _start.PID], 0 ; Main thread PID.
    
    ;Allowing parent process to automatically reap children as SYS_KILL is executed in them.
    MOV RAX, SYS_RT_SIGACTION
    MOV RDI, SIGCHLD
    MOV RSI, main_sigAction
    MOV RDX, 0
    MOV R10, 8 ; 8 bytes.
    SYSCALL
    
    ; Find main PID.
    MOV RAX, SYS_GETTID
    SYSCALL
    MOV [RBP - _start.PID], RAX
    
    CMP QWORD [RBP+_start.argc], 1
    JE .failure
    CALL FSM
    ;Place INT3 after CALL FSM for debugging
    
    MOV RAX, SYS_EXIT
    XOR RDI, RDI
    SYSCALL
    
    
    
    .failure:
        MOV RAX, SYS_WRITE
        MOV RDI, STDOUT
        MOV RSI, errorMsg.txt
        MOV RDX, errorMsg.len
        SYSCALL
        
        MOV RAX, SYS_EXIT
        XOR RDI, RDI
        SYSCALL
