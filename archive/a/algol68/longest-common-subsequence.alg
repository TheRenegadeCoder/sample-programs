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

PROC usage = VOID: printf(($gl$, "Usage: please provide two lists in the format ""1, 2, 3, 4, 5"""));

COMMENT
Longest Common Sequence
Source: https://en.wikipedia.org/wiki/Longest_common_subsequence#Example_in_C#

However, instead of storing lengths, the entire subsequence is stored
COMMENT
PROC longest common subsequence = (REF []INT list1, REF []INT list2) REF []INT:
(
    # Allocate space for all of the subsequence pointers #
    INT m := UPB list1;
    INT n := UPB list2;
    HEAP [0..m, 0..n]REF []INT c;

    # Initialize subsequences of zero length #
    HEAP [0]INT empty list := ();
    FOR i FROM 0 TO m
    DO
        c[i, 0] := empty list
    OD;

    FOR j FROM 0 TO n
    DO
        c[0, j] := empty list
    OD;

    # Find the longest common subsequence using prior subsequences #
    INT num elems;
    FOR i TO m
    DO
        FOR j TO n
        DO
            # If common element found, create new subsequence based on prior #
            # subsequence with the common element appended #
            IF list1[i] = list2[j]
            THEN
                num elems := ELEMS c[i - 1, j - 1];
                c[i, j] := HEAP [num elems + 1]INT;
                c[i, j][1..num elems] := c[i - 1, j - 1];
                c[i, j][num elems + 1] := list1[i]
            # Else, reuse the longer of the two prior subsequences #
            ELSE
                c[i, j] := (ELEMS c[i, j - 1] > ELEMS c[i - 1, j] | c[i, j - 1] | c[i - 1, j])
            FI
        OD
    OD;

    c[m, n]
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

# Parse 1st and 2nd command-line arguments #
[2]REF []INT lists;
[2]INT argnums := (4, 5);
FOR k TO 2
DO
    STRING s := argv(argnums[k]);
    PARSEINTLIST_RESULT list result := parse int list(s);
    lists[k] := values OF list result;
    IF NOT valid OF list result
    THEN
        usage;
        stop
    FI
OD;

# Get longest common subsequence and display it #
REF []INT result = longest common subsequence(lists[1], lists[2]);
show list values(result)
