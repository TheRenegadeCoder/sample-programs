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
    printf(($gl$, "Usage: please provide a list of integers (e.g. ""8, 3, 1, 2"")"))
);

COMMENT
Find maximum array rotation, max{W(k), k=0..N-1}, where:

    W(k) = sum{i*a[i+k mod N], i=0..N-1}

The value of W(k) can be calculated from W(k-1) as follows:

    W(k) = W(k-1) - S + N*a[k-1]

where:

    S = sum{a[i], i=0..N-1} = sum{a[i+x mod N], i=0..N-1}

where: x is any arbitary value

Proof:

- Set up initial assumption for W(k):

    W(k-1) - S + N*a[k-1] = sum{i*a[i+k-1 mod N], i=0..N-1} - sum{a[i+k-1 mod N}, i=0..N-1} + N*a[k-1]

- Combine the two sums:

    = sum{(i-1)*a[i+k-1 mod N], i=0..N-1} + N*a[k-1]

- Pull out the i=0 term:
    = -a[k-1] + sum{(i-1)*a[i+k-1 mod N], i=1..N-1} + N*a[k-1]

- Combine the a[k-1] terms:

    = sum{(i-1}*a[i+k-1 mod N], i=1..N-1) + (N-1)*a[k-1]

- Change indexing from i=1..N-1 to 0..N-2:

    = sum{i*a[i+k mod N], i=0..N-2} + (N-1)*a[k-1]

- Bring the i=N-1 term back into the sum since N-1+k mod N equals k-1:

    = sum{i*a[i+k mod N], i=0..N-1}

- The above equals W(k)
COMMENT
PROC maximum array rotation = (REF []INT values) INT:
(
    # Calculate sum and initial array rotation #
    INT s := 0;
    INT w := 0;
    INT n = UPB values;
    FOR i TO n
    DO
        s +:= values[i];
        w +:= (i - 1) * values[i]
    OD;

    # Initialize maximum array rotation #
    INT wmax := w;

    # Adjust array rotation and update maximum #
    FOR i TO n - 1
    DO
        w +:= n * values[i] - s;
        IF w > wmax
        THEN
            wmax := w
        FI
    OD;

    wmax
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

# Find maximum array rotation and display result #
INT value = maximum array rotation(values);
printf(($gl$, whole(value, 0)))
