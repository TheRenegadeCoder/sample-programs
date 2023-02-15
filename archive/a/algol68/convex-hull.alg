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
    printf(($gl$, "Usage: please provide at least 3 x and y coordinates as separate lists (e.g. ""100, 440, 210"")"))
);

# Combine values into a set of points #
MODE POINT = STRUCT(INT x, INT y);
OP = =(POINT p1, POINT p2) BOOL: (x OF p1 = x OF p2) AND (y OF p1 = y OF p2);

PROC form points = (REF []INT x values, REF []INT y values) REF []POINT:
(
    INT n = UPB x values;
    HEAP [n]POINT points;
    FOR k TO n
    DO
        points[k] := POINT(x values[k], y values[k])
    OD;

    points
);

COMMENT
Find Convex Hull using Jarvis' algorithm
Source: https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/
COMMENT
PROC convex hull = (REF []POINT points) REF []POINT:
(
    INT n := UPB points;

    # hull will be the set of points which form the convex hull. #
    # Final set size is i #
    HEAP [n]POINT hull;

    # The first point is the leftmost point with the highest y-coord in the #
    # event of a tie #
    INT l := find leftmost point(points);

    # Repeat until wrapped around to first hull point #
    INT p := l;
    INT q;
    INT i := 0;
    DO
        # Store conex hull point #
        i +:= 1;
        hull[i] := points[p];

        q := 1 + p MOD n;
        FOR j TO n
        DO
            # If point j is more counter-clockwise, then update end point (q) #
            IF orientation(points[p], points[j], points[q]) < 0
            THEN
                q := j
            FI
        OD;

        p := q
    UNTIL p = l
    OD;
    hull[1:i]
);

PROC find leftmost point = (REF []POINT points) INT:
(
    INT n := UPB points;
    INT min x := max int;
    INT max y := -max int;
    INT min index := 1;
    INT x;
    INT y;
    FOR k TO n
    DO
        # In the event of a tie, pick the point with the greater y-coord #
        x := x OF points[k];
        y := y OF points[k];
        IF (x < min x) OR (x = min x AND y > max y)
        THEN
            min x := x;
            max y := y;
            min index := k
        FI
    OD;

    min index
);

COMMENT
Get orientation of three points

0 = points are in a line
> 0 = points are counter-clockwise
< 0 = points are clockwise
COMMENT
PROC orientation = (POINT p, POINT q, POINT r) INT:
(
    (
        (y OF q - y OF p) * (x OF r - x OF q) -
        (x OF q - x OF p) * (y OF r - y OF q)
    )
);

# Show points #
PROC show points = (REF []POINT points) VOID:
(
    INT n := UPB points;
    FOR k TO n
    DO
        printf(($"("g", "g")"l$, whole(x OF points[k], 0), whole(y OF points[k], 0)))
    OD
);

# Parse 1st and 2nd command-line arguments #
[2]REF []INT values;
[2]INT argnums := (4, 5);
FOR k TO 2
DO
    STRING s := argv(argnums[k]);
    PARSEINTLIST_RESULT list result := parse int list(s);
    values[k] := values OF list result;
    IF NOT valid OF list result OR UPB values[k] < 3
    THEN
        usage;
        stop
    FI
OD;

# Make sure same number of points #
IF UPB values[1] /= UPB values[2]
THEN
    usage;
    stop
FI;

# Combine values into set of points #
REF []POINT points = form points(values[1], values[2]);

# Get convex hull of points and show points #
REF []POINT hull points = convex hull(points);
show points(hull points)
