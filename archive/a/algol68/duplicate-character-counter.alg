PROC usage = VOID: printf(($gl$, "Usage: please provide a string"));

PROC duplicate character counter = (STRING s) REF []INT:
(
    # Initialize character counter #
    HEAP [0..255]INT char counter;
    FOR k FROM LWB char counter TO UPB char counter
    DO
        char counter[k] := 0
    OD;

    # Count number of occurances of each character #
    FOR k TO UPB s
    DO
        char counter[ABS s[k]] +:= 1
    OD;

    char counter
);

PROC show duplicate character counts = (STRING s, REF []INT char counter) VOID:
(
    BOOL has dupes := FALSE;
    INT code;
    FOR k TO UPB s
    DO
        code := ABS s[k];
        IF char counter[code] > 1
        THEN
            printf(($g": "gl$, s[k], whole(char counter[code], 0)));
            char counter[code] := 0;
            has dupes := TRUE
        FI
    OD;

    IF NOT has dupes
    THEN
        printf(($gl$, "No duplicate characters"))
    FI
);

# Get 1st command-line argument. Exit if empty #
STRING s := argv(4);
IF UPB s = 0
THEN
    usage;
    stop
FI;

# Count duplicate characters #
REF []INT char counter := duplicate character counter(s);

# Show all duplicate character counts in order in which they occurred in string (if any) #
show duplicate character counts(s, char counter)
