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

INT longest word len := 0;
INT word len := 0;
FOR n TO UPB s
DO
    # If whitespace, reset word length #
    IF isspace(s[n])
    THEN
        word len := 0
    # Else increment word length and update longest word length #
    ELSE
        word len +:= 1;
        IF word len > longest word len
        THEN
            longest word len := word len
        FI
    FI
OD;

print((whole(longest word len, 0), newline))
