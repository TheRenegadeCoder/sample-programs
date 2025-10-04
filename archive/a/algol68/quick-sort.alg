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
Source: https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme
COMMENT
PROC quick sort = (REF []INT values) VOID:
(
    quick sort rec(values, 1, UPB values)
);

PROC quick sort rec = (REF []INT values, INT lo, INT hi) VOID:
(
    IF lo < hi AND lo >= 1
    THEN
        # Partition array and get pivot value #
        INT p := partition(values, lo, hi);

        # Sort left side of partition #
        quick sort rec(values, lo, p - 1);

        # Sort right side of partition #
        quick sort rec(values, p + 1, hi)
    FI
);

PROC partition = (REF []INT values, INT lo, INT hi) INT:
(
    # Choose last value as pivot #
    INT pivot = values[hi];

    # Set temporary pivot index #
    INT i := lo - 1;

    # Swap elements less than or equal to pivot, and increment temporary index #
    FOR j FROM lo TO hi - 1
    DO
        IF values[j] <= pivot
        THEN
            i +:= 1;
            swap(values, i, j)
        FI
    OD;

    # Move pivot to correct position #
    i +:= 1;
    swap(values, i, hi);

    i
);

PROC swap = (REF []INT values, INT a, INT b) VOID:
(
    INT temp := values[a];
    values[a] := values[b];
    values[b] := temp
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
REF []INT values := values OF list result;
IF NOT valid OF list result OR UPB values < 2
THEN
    usage;
    stop
FI;

# Do quick sort and show results #
quick sort(values);
show list values(values)
