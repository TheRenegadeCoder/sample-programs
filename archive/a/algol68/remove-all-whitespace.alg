PROC usage = VOID: printf(($gl$, "Usage: please provide a string"));

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

STRING t;
FOR n TO UPB s
DO
    IF NOT isspace(s[n])
    THEN
        t +:= s[n]
    FI
OD;

printf(($gl$, t))
