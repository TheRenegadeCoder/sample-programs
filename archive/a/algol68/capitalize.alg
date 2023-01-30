PROC usage = VOID: printf(($gl$, "Usage: please provide a string"));

PROC capitalize = (STRING s) STRING:
(
    # If first letter is lowercase, capitalize it #
    (islower(s[1]) | toupper(s[1]) | s[1]) + s[2:]
);

# Get 1st command-line argument. Exit if empty #
STRING s := argv(4);
IF UPB s = 0
THEN
    usage;
    stop
FI;

# Capitalize string and show it #
s := capitalize(s);
printf(($gl$, s))
