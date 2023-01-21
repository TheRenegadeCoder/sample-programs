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

PROC usage = VOID: printf(($gl$, "Usage: please input the count of fibonacci numbers to output"));

MODE FIBSTATE = STRUCT(INT prev, INT result);
PROC init fib = FIBSTATE: FIBSTATE(0, 1);
OP FIB = (FIBSTATE state) FIBSTATE: (result OF state, prev OF state + result OF state);
OP FIBRESULT = (FIBSTATE state) INT: prev OF state;

# Command-line arguments start at 4. If too few, exit #
IF argc < 4
THEN
    usage;
    stop
FI;

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINT_RESULT result := parse int(s);

# If invalid, extra characters, exit #
INT n := value OF result;
IF NOT (valid OF result) OR (leftover OF result) /= ""
THEN
    usage;
    stop
FI;

FIBSTATE state := init fib;
FOR k TO n
DO
    state := FIB state;
    print((whole(k, 0), ": ", whole(FIBRESULT state, 0), newline))
OD
