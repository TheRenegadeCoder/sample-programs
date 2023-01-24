PROC usage = VOID: printf(($gl$, "Usage: please provide a string to encrypt"));

# Command-line arguments start at 4. If too few, exit #
IF argc < 4
THEN
    usage;
    stop
FI;

# Get 1st command-line argument. Exit if empty #
STRING s := argv(4);
IF UPB s = 0
THEN
    usage;
    stop
FI;

INT code;
FOR n TO UPB s
DO
    # If A-M or a-m, convert to N-Z or n-z by adding 13 to ASCII code #
    # Else, convert to A-M or a-m by subtracting 13 from ASCII code #
    IF isalpha(s[n])
    THEN
        code := ABS s[n];
        code +:= (tolower(s[n]) <= "m" | 13 | -13);
        s[n] := REPR code
    FI
OD;

printf(($gl$, s))
