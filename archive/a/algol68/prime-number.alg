# Command-line arguments start at 4 #
IF argc < 4
THEN
    usage
FI;

# Parse 1st command-line argument #
FILE f;
REAL r := 0.0;
STRING s := argv(4);
associate(f, s);
on logical file end(f, (REF FILE inf) BOOL:
    (
        close(inf);
        usage;
        stop 
    )
);
on value error(f, (REF FILE inf) BOOL:
    (
        close(inf);
        usage;
        stop 
    )
);
get(f, r);
close(f);

# If not integer, exit #
INT n = ENTIER(r);
IF n /= r
THEN
    usage
FI;

# If negative, exit #
IF n < 0
THEN
    usage
FI;

# Check prime by divisibility #
BOOL is prime := TRUE;
IF n < 2 OR (n /= 2 AND n MOD 2 = 0)
THEN
    is prime := FALSE
ELSE
    INT q := ENTIER(sqrt(n));
    INT k = 3;
    FOR k FROM 3 BY 2 TO q
    WHILE is prime
    DO
        IF n MOD k = 0
        THEN
            is prime := FALSE
        FI
    OD
FI;

printf(($gl$, (is prime | "Prime" | "Composite")));
done;

usage: printf(($gl$, "Usage: please input a non-negative integer"));
done: stop
