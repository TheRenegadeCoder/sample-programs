PROC usage = VOID: printf(($gl$, "Usage: please provide a string to encrypt"));

PROC rot13 = (STRING s) STRING:
(
    INT code;
    STRING t;
    FOR n TO UPB s
    DO
        # If A-M or a-m, convert to N-Z or n-z by adding 13 to ASCII code #
        # Else, convert to A-M or a-m by subtracting 13 from ASCII code #
        code := ABS s[n];
        IF isalpha(s[n])
        THEN
            code +:= (tolower(s[n]) <= "m" | 13 | -13)
        FI;

        t +:= REPR code
    OD;

    t
);

# Get 1st command-line argument. Exit if empty #
STRING s := argv(4);
IF UPB s = 0
THEN
    usage;
    stop
FI;

# Encrypt string with ROT13 and display #
s := rot13(s);
printf(($gl$, s))
