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

PROC usage = VOID: printf(($gl$, "Usage: please provide a comma-separated list of integers"));

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

COMMENT
Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
COMMENT
MODE MST = STRUCT(INT vertex1, INT vertex2, INT weight);
PROC prim mst = (REF [, ]INT graph) REF []MST:
(
    INT num vertices := UPB graph;

    # Array to store constructed MST #
    [num vertices]INT parents;

    # Key values used to pick minimum weight edge #
    [num vertices]INT keys;

    # Array used to indicate if vertex is in MST #
    [num vertices]BOOL mst set;

    # Initialize key values to infinite and indicate nothing is in MST yet #
    FOR k TO num vertices
    DO
        keys[k] := max int;
        mst set[k] := FALSE
    OD;

    # Include first vertex in MST #
    keys[1] := 1;
    parents[1] := 0; # Root has no parent #

    # The MST will include all vertices #
    FOR k TO num vertices - 1
    DO
        # Pick index of the minimum key value not already in MST #
        INT u := find min key(keys, mst set);

        # Add picked vertex to MST set #
        mst set[u] := TRUE;

        # Update key values and parent indices of picked adjacent #
        # vertices. Only consider vertices not yet in MST #
        FOR v TO num vertices
        DO
            INT graph value := graph[u, v];
            IF NOT mst set[v] AND graph value > 0 AND graph value < keys[v]
            THEN
                parents[v] := u;
                keys[v] := graph value
            FI
        OD
    OD;

    # Construct MST information to return #
    HEAP [num vertices - 1]MST mst;

    # Skip over root and adjust vertex numbers to account for 1-based indexing #
    FOR k FROM 2 TO num vertices
    DO
        mst[k - 1] := MST(parents[k] - 1, k - 1, graph[k, parents[k]])
    OD;

    mst
);

# Find vertex with minimum key values not already in MST #
PROC find min key = (REF []INT keys, REF []BOOL mst set) INT:
(
    INT min value := max int;
    INT min index;
    FOR v TO UPB keys
    DO
        IF keys[v] < min value AND NOT mst set[v]
        THEN
            min value := keys[v];
            min index := v
        FI
    OD;

    min index
);

# Get total MST weight #
PROC get total mst weight = (REF []MST mst) INT:
(
    INT total weight := 0;
    FOR v TO UPB mst
    DO
        total weight +:= weight OF mst[v]
    OD;

    total weight
);

# Parse 1st command-line argument and make sure number of values is a square #
STRING s := argv(4);
PARSEINTLIST_RESULT list result := parse int list(s);
REF []INT values := values OF list result;
INT num values := UPB values;
INT sqrt num values := ENTIER(sqrt(num values) + 0.5);
IF NOT valid OF list result OR num values /= sqrt num values * sqrt num values
THEN
    usage;
    stop
FI;

# Convert values to matrix #
REF [, ]INT graph := convert to matrix(values, sqrt num values, sqrt num values);

# Get MST using Prim's algorithm #
REF []MST mst := prim mst(graph);

# Calculate total weight of MST and display #
INT total weight := get total mst weight(mst);
printf(($gl$, whole(total weight, 0)))
