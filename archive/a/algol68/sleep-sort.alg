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
    printf(($gl$, "Usage: please provide a list of at least two integers to sort in the format ""1, 2, 3, 4, 5"""))
);

COMMENT
Algol68 does not have any type of mechanism to sleep for a specified time,
nor do threads seems to work reliably. Instead, just monitor the clock
and store values as each sleep time elapses
COMMENT
PROC sleep sort = (REF []INT sleep times) REF []INT:
(
    INT n := UPB sleep times;
    HEAP [n]INT working sleep times := sleep times;
    HEAP [n]INT values;
    INT num values := 0;

    # For each sleep time that is not complete, when sleep time expires, append the #
    # sleep time to the list of values and remove the sleep time from the list #
    REAL start := seconds;
    DO
        REAL current := seconds;
        INT num sleep times := 0;
        FOR k TO n
        DO
            IF (current - start) >= working sleep times[k]
            THEN
                num values +:= 1;
                values[num values] := working sleep times[k]
            ELSE
                num sleep times +:= 1;
                working sleep times[num sleep times] := working sleep times[k]
            FI
        OD;

        n := num sleep times
    UNTIL num sleep times < 1
    OD;

    values
);

PROC show list values = (REF []INT values) VOID:
(
    INT n = UPB values;
    FOR k TO n
    DO
        IF k > 1
        THEN
            print(", ")
        FI;

        print(whole(values[k], 0))
    OD;

    IF n > 0
    THEN
        print(newline)
    FI
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINTLIST_RESULT list result := parse int list(s);
REF []INT sleep times := values OF list result;
IF NOT valid OF list result OR UPB sleep times < 2
THEN
    usage;
    stop
FI;

# Do sleep sort and show results #
REF []INT values := sleep sort(sleep times);
show list values(values)
