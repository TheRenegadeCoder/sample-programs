MODE PARSEINT_RESULT = STRUCT(BOOL valid, INT value, STRING leftover);
MODE PARSEINTLIST_RESULT = STRUCT(BOOL valid, FLEX [1:0]INT values);

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
    PARSEINT_RESULT(valid, n, leftover)
);

PROC parse int list = (REF STRING s) PARSEINTLIST_RESULT:
(
    BOOL valid := FALSE;
    STRING leftover := s;
    FLEX [1:0]INT values;

    # Repeat until invalid value or end of string #
    DO
        # Get next integer value and update leftover string #
        PARSEINT_RESULT result = parse int(leftover);
        valid := valid OF result;
        leftover := leftover OF result;

        IF valid
        THEN
            # Append the integer value #
            [UPB values + 1]INT temp values;
            temp values[:UPB values] := values;
            temp values[UPB values + 1] := value OF result;
            values := temp values;

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
        FI
    UNTIL NOT valid OR leftover = ""
    OD;

    PARSEINTLIST_RESULT(valid, values)
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINTLIST_RESULT result := parse int list(s);
printf(($"valid="gl$, valid OF result));

REF []INT values := values OF result;
FOR k TO UPB values
DO
    printf(($g": "gl$, whole(k, 0), whole(values[k], 0)))
OD

