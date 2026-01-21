# Number of Fibonacci numbers before the math overflows #
INT max fibonaccis = 43;

MODE PARSEINT_RESULT = STRUCT(BOOL valid, INT value, STRING leftover);

PROC parse int = (REF STRING s) PARSEINT_RESULT:
(
    BOOL valid := FALSE;
    REAL r := 0.0;
    INT n := 0;
    STRING leftover;

    # Associate string with a file #
    FILE f;
    associate(f, s);

    # On end of input, exit if valid number not seen. Otherwise ignore it #
    on logical file end(f, (REF FILE dummy) BOOL:
        (
            IF NOT valid THEN done FI;
            TRUE
        )
    );

    # Exit if value error #
    on value error(f, (REF FILE dummy) BOOL: done);

    # Convert string to real number #
    get(f, r);

    # If real number is in range of an integer, convert to integer. Indicate integer is valid if same as real #
    IF ABS r <= max int
    THEN
        n := ENTIER(r);
        valid := (n = r)
    FI;

    # Get leftover string #
    get(f, leftover);

done:
    close(f);
    PARSEINT_RESULT(valid, n, leftover)
);

PROC usage = VOID: printf(($gl$, "Usage: please input a non-negative integer"));

COMMENT
fib(n) = fib(n - 1) + fib(n - 2)
where:
- fib(0) = 0
- fib(1) = 1
- fib(2) = 1
- fib(3) = 2
COMMENT
MODE FIBSTATE = STRUCT(INT prev, INT result);
PROC init fib = FIBSTATE: FIBSTATE(1, 2);
OP FIB = (FIBSTATE state) FIBSTATE: (result OF state, prev OF state + result OF state);
OP FIBRESULT = (FIBSTATE state) INT: prev OF state;

PROC fibonacci up to = (INT n) REF [] INT:
(
    # Temporary array that can handle Fibonacci numbers #
    REF [] INT temp results = HEAP [1:max fibonaccis] INT;

    # Initialize Fibonacci state #
    FIBSTATE state := init fib;

    # Collect all Fibonacci numbers up to the specified value #
    INT idx := 0;
    WHILE FIBRESULT state <= n AND idx < max fibonaccis
    DO
        idx +:= 1;
        temp results[idx] := FIBRESULT state;
        state := FIB state
    OD;

    # Resize results #
    REF [] INT results := HEAP [1:idx] INT;
    results := temp results[1:idx];
    results
);

PROC zeckendorf = (INT n) REF [] INT:
(
    # Get Fibonacci numbers up to and including n #
    REF [] INT fibs = fibonacci up to(n);

    # Allocate temporary space for Zeckendorf values #
    INT num fibs := UPB fibs;
    REF [] INT temp results := HEAP [1:num fibs] INT;

    # Going from largest to smallest, repeat until no more Fibonacci numbers #
    # left or sum of Fibonacci numbers is equal to n #
    INT fib idx := num fibs;
    INT zeck idx := 0;
    INT remaining := n;
    WHILE fib idx > 0 AND remaining > 0
    DO
        # If this Fibonacci number is less than or equal to n, use it and skip the #
        # previous Fibonacci number. Otherwise, go to previous Fibonacci number #
        INT fib = fibs[fib idx];
        IF fib <= remaining
        THEN
            zeck idx +:= 1;
            temp results [zeck idx] := fib;
            fib idx -:= 2;
            remaining -:= fib
        ELSE
            fib idx -:= 1
        FI
    OD;

    # Resize results #
    REF [] INT results := HEAP [1:zeck idx] INT;
    results := temp results[1:zeck idx];
    results
);

PROC show list values = (REF []INT values) VOID:
(
    INT n = UPB values;
    FOR k TO n
    DO
        IF k > 1
        THEN
            print(", ")
        FI;

        print(whole(values[k], 0))
    OD;

    IF n > 0
    THEN
        print(newline)
    FI
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINT_RESULT result := parse int(s);

# If invalid or extra characters or negative number, exit #
INT n := value OF result;
IF NOT (valid OF result) OR (leftover OF result) /= "" OR n < 0
THEN
    usage;
    stop
FI;

REF [] INT results := zeckendorf(n);
show list values(results)
