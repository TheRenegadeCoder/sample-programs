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

PROC usage = VOID: printf(($gl$, "Usage: please enter the dimension of the matrix and the serialized matrix"));

# Convert list of values to a matrix #
PROC convert to matrix = (REF []INT values, INT num rows, INT num cols) REF [, ]INT:
(
    HEAP [num rows, num cols]INT matrix;
    INT count := 0;
    FOR i TO num rows
    DO
        FOR j TO num cols
        DO
            count +:= 1;
            matrix[i, j] := values[count]
        OD
    OD;

    matrix
);

# Return a transposed version of a matrix #
PROC transpose matrix = (REF [, ]INT matrix) REF [, ]INT:
(
    # Use built-in transpose operator #
    TRNSP matrix
);

# Show matrix as a list of comma-separated values #
PROC show matrix as list = (REF [, ]INT matrix) VOID:
(
    INT num rows = 1 UPB matrix;
    INT num cols = 2 UPB matrix;
    FOR i TO num rows
    DO
        FOR j TO num cols
        DO
            IF i > 1 OR j > 1
            THEN
                print(", ")
            FI;

            print(whole(matrix[i, j], 0))
        OD
    OD;

    print(newline)
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINT_RESULT result := parse int(s);
INT num cols := value OF result;
IF NOT valid OF result OR num cols < 1
THEN
    usage;
    stop
FI;

# Parse 2nd command-line argument #
s := argv(5);
result := parse int(s);
INT num rows := value OF result;
IF NOT valid OF result OR num rows < 1
THEN
    usage;
    stop
FI;

# Parse 3rd command-line argument and make sure that it is the product #
# of the number of rows and columns #
s := argv(6);
PARSEINTLIST_RESULT list result := parse int list(s);
REF []INT values := values OF list result;
INT num values := UPB values;
IF NOT valid OF list result OR num values /= num rows * num cols
THEN
    usage;
    stop
FI;

# Convert values to matrix #
REF [, ]INT matrix := convert to matrix(values, num rows, num cols);

# Transpose matrix #
REF [, ]INT matrix t := transpose matrix(matrix);

# Show transposed matrix as a list #
show matrix as list(matrix t)
