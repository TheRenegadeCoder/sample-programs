MODE PARSEINT_RESULT = STRUCT(BOOL valid, INT value, STRING leftover);
MODE PARSEINTLIST_RESULT = STRUCT(BOOL valid, REF []INT values);

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

PROC usage = VOID: printf(($gl$, "Usage: please input the total number of people and number of people to skip."));

COMMENT
Reference: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case

Use zero-based index algorithm:

    g(1, k) = 0
    g(m, k) = [g(m - 1, k) + k] MOD m, for m = 2, 3, ..., n

Final answer is g(n, k) + 1 to get back to one-based index
COMMENT
PROC josephus = (INT n, INT k) INT:
(
    INT g := 0;
    FOR m FROM 2 TO n
    DO
        g := (g + k) MOD m
    OD;

    g + 1
);

# Parse 1st and 2nd command-line arguments #
[2]INT values;
FOR m TO 2
DO
    STRING s := argv(m + 3);
    PARSEINT_RESULT result := parse int(s);

    # If invalid, extra characters, exit #
    values[m] := value OF result;
    IF NOT (valid OF result) OR (leftover OF result) /= ""
    THEN
        usage;
        stop
    FI
OD;

INT n := values[1];
INT k := values[2];
INT g := josephus(n, k);
printf(($gl$, whole(g, 0)))
