MODE PARSEINT_RESULT = STRUCT(BOOL valid, INT value, STRING leftover);
MODE PARSEINTLIST_RESULT = STRUCT(BOOL valid, REF []INT values);

PROC parse int = (REF STRING s) PARSEINT_RESULT:
(
    BOOL valid := FALSE;
    REAL r := 0.0;
    INT n := 0;
    STRING leftover;

    # Associate string with a file #
    FILE f;
    associate(f, s);

    # On end of input, exit if valid number not seen. Otherwise ignore it #
    on logical file end(f, (REF FILE dummy) BOOL:
        (
            IF NOT valid THEN done FI;
            TRUE
        )
    );

    # Exit if value error #
    on value error(f, (REF FILE dummy) BOOL: done);

    # Convert string to real number #
    get(f, r);

    # If real number is in range of an integer, convert to integer. Indicate integer is valid if same as real #
    IF ABS r <= max int
    THEN
        n := ENTIER(r);
        valid := (n = r)
    FI;

    # Get leftover string #
    get(f, leftover);

done:
    close(f);
    PARSEINT_RESULT(valid, n, leftover)
);

PROC count list items = (STRING s) INT:
(
    INT count := 1;
    FOR k TO UPB s
    DO
        IF s[k] = ","
        THEN
            count +:= 1
        FI
    OD;

    count
);

PROC parse int list = (REF STRING s) PARSEINTLIST_RESULT:
(
    BOOL valid := FALSE;
    STRING leftover := s;
    INT num list items = count list items(s);
    HEAP [num list items]INT values;

    # Repeat while valid value #
    FOR k TO num list items
    DO
        # Get next integer value and update leftover string #
        PARSEINT_RESULT result = parse int(leftover);
        valid := valid OF result;
        leftover := leftover OF result;

        # Append the integer value to list #
        values[k] := value OF result;

        # Do nothing if end of string #
        IF leftover = ""
        THEN
            SKIP
        # Skip comma if leftover string starts with comma #
        ELIF leftover[1] = ","
        THEN
            leftover := leftover[2:]
        # Otherwise indicate invalid #
        ELSE
            valid := FALSE
        FI
    UNTIL NOT valid
    OD;

    PARSEINTLIST_RESULT(valid, values)
);

PROC usage = VOID: (
    printf(($gl$, "Usage: please provide a list of integers (""1, 4, 5, 11, 12"") and the integer to find (""11"")"))
);

PROC linear search = (INT target, REF []INT values) INT:
(
    INT found := 0;
    FOR k TO UPB values
    WHILE found = 0
    DO
        IF values[k] = target
        THEN
            found := k
        FI        
    OD;

    found
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINTLIST_RESULT list result := parse int list(s);
REF []INT values := values OF list result;
IF NOT valid OF list result
THEN
    usage;
    stop
FI;

# Parse 2nd command-line argument #
s := argv(5);
PARSEINT_RESULT result := parse int(s);
INT target := value OF result;
IF NOT valid OF result OR leftover OF result /= ""
THEN
    usage;
    stop
FI;

# Do linear search and show results #
INT index = linear search(target, values);
printf(($gl$, (index > 0 | "true" | "false")))
