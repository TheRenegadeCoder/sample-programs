PROC usage = VOID: printf(($gl$, "Usage: please provide a string"));

# Get 1st command-line argument. Exit if empty #
STRING s := argv(4);
IF UPB s = 0
THEN
    usage;
    stop
FI;

# If first letter is lowercase, capitalize it #
IF islower(s[1])
THEN
    s[1] := toupper(s[1])
FI;

printf(($gl$, s))
