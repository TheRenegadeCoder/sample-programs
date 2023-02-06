PROC usage = VOID: printf(($gl$, "Usage: please provide a string"));

PROC reverse string = (STRING s) STRING:
(
    STRING t;
    FOR n FROM UPB s DOWNTO 1
    DO
        t +:= s[n]
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

# Reverse string and show result #
s := reverse string(s);
printf(($gl$, s))
