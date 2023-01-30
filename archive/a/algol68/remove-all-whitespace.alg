PROC usage = VOID: printf(($gl$, "Usage: please provide a string"));

PROC remove all whitespace := (STRING s) STRING:
(
    STRING t;
    FOR n TO UPB s
    DO
        IF NOT isspace(s[n])
        THEN
            t +:= s[n]
        FI
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

# Remove all whitespace and display result #
s := remove all whitespace(s);
printf(($gl$, s))
