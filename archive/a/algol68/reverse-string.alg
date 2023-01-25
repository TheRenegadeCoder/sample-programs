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

CHAR temp;
INT len := UPB s;
FOR n TO len OVER 2
DO
    temp := s[len + 1 - n];
    s[len + 1 - n] := s[n];
    s[n] := temp
OD;

printf(($gl$, s))
