MODE PARSEINT_RESULT = STRUCT(BOOL valid, INT value, STRING leftover);
INT zero := ABS "0";

PROC find non blank = (STRING s, INT start) INT:
(
    INT pos := start;
    FOR k FROM pos TO UPB(s)
    WHILE isspace(s[k])
    DO
        pos +:= 1
    OD;

    pos
);

PROC parse int = (STRING s) PARSEINT_RESULT:
(
    BOOL valid := FALSE;
    INT sign := 1;
    REAL r := 0.0;
    INT n := 0;

    # Skip blanks #
    INT pos := find non blank(s, 1);

    # Handle sign #
    INT len := UPB(s);
    FROM pos TO len
    WHILE s[pos] = "+" OR s[pos] = "-"
    DO
        IF s[pos] = "-"
        THEN
            sign := -sign
        FI;

        pos +:= 1
    OD;

    # Convert the string to an integer until end-of-string or non-digit #
    FROM pos TO len
    WHILE isdigit(s[pos])
    DO
        valid := TRUE;
        r := r * 10.0 + (ABS s[pos]) - zero;
        pos +:= 1
    OD;

    # Make sure value is in range #
    r *:= sign;
    IF r < -(max int + 1.0) OR r > max int
    THEN
        valid := FALSE
    ELSE
        n := ENTIER(r)
    FI;

    pos := find non blank(s, pos);
    PARSEINT_RESULT(valid, n, s[pos:])
);

PROC usage = VOID: printf(($gl$, "Usage: please input the total number of people and number of people to skip."));

# Command-line arguments start at 4. Expecting 2 arguments. If too few, exit #
IF argc < 5
THEN
    usage;
    stop
FI;

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

COMMENT
Reference: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case

Use zero-based index algorithm:

    g(1, k) = 0
    g(m, k) = g(m-1, k) MOD m, for m = 1, 2, ..., n

Final answer is g(n, k) + 1 to get back to one-based index
COMMENT

INT n := values[1];
INT k := values[2];
INT g := 0;
FOR m TO n
DO
    g := (g + k) MOD m  # g(m, k) = [g(m - 1) + k] mod m #
OD;

printf(($gl$, whole(g + 1, 0)))
