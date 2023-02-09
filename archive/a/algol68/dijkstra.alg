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

PROC usage = VOID:
(
    printf(($gl$, "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"))
);

PROC validate inputs = (REF []INT weights, INT num vertices, INT src, INT dest) BOOL:
(
    BOOL valid := TRUE;

    # Verify number of weights is a square #
    INT num weigths := UPB weights;
    IF num weights /= num vertices * num vertices
    THEN
        valid := FALSE
    FI;

    # Verify weights greater than equal to zero and at any non-zero weights #
    BOOL any non zero := FALSE;
    FOR k TO num weights
    WHILE valid
    DO
        IF weights[k] > 0
        THEN
            any non zero := TRUE
        FI;

        IF weights[k] < 0
        THEN
            valid := FALSE
        FI
    OD;

    IF NOT any non zero
    THEN
        valid := FALSE
    FI;

    # Verify source and destination are in range #
    IF src < 0 OR src >= num vertices OR dest < 0 OR dest >= num vertices
    THEN
        valid := FALSE
    FI;

    valid
);

# Create graph based on weights #
MODE NODE = STRUCT(INT vertex, INT weight);
MODE NODES = REF []NODE;
MODE GRAPH = STRUCT(INT num vertices, REF []NODES edges);
PROC create graph = (INT num vertices, REF []INT weights) GRAPH:
(
    HEAP [num vertices]NODES edges;
    INT index := 0;
    FOR u TO num vertices
    DO
        INT num edges := 0;
        FOR v TO num vertices
        DO
            IF weights[index + v] > 0
            THEN
                num edges +:= 1
            FI
        OD;

        edges[u] := HEAP [num edges]NODE;
        num edges := 0;
        FOR v TO num vertices
        DO
            index +:= 1;
            IF weights[index] > 0
            THEN
                num edges +:= 1;
                edges[u][num edges] := NODE(v, weights[index])
            FI
        OD
    OD;

    GRAPH(num vertices, edges)
);

COMMENT
Dijkstra's algorithm
Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
COMMENT
MODE DIJKSTRA_RESULT = STRUCT(REF []INT dists, REF []INT prevs);
PROC dijkstra = (GRAPH graph, INT src) DIJKSTRA_RESULT:
(
    # Initialize distances to infinite and previous vertices to undefined #
    # Set first vertex distange to 0 #
    # Initialize unvisited nodes #
    INT num vertices := num vertices OF graph;
    HEAP [num vertices]INT dists;
    HEAP [num vertices]INT prevs;
    HEAP [num vertices]INT q;
    INT num unvisited := num vertices;
    FOR v TO num vertices
    DO
        dists[v] := max int;
        prevs[v] := 0;
        q[v] := v
    OD;

    dists[src + 1] := 0;

    # While any unvisited nodes #
    INT u;
    INT v;
    INT alt;
    WHILE num unvisited > 0
    DO
        # Pick a vertex u in Q with minimum distance #
        u := min distance(dists, q);

        # Remove vertex u from Q #
        IF q[u] > 0
        THEN
            num unvisited -:= 1
        FI;
        q[u] := 0;

        # For each neighbor v of vertex u in still in Q #
        REF []NODE edges := (edges OF graph)[u];
        FOR index TO UPB edges
        DO
            v := vertex OF edges[index];
            IF q[v] > 0
            THEN
                # Get trial distance #
                alt := dists[u] + weight OF edges[index];

                # If trial distance is smaller than distance v, update distance to v and #
                # previous vertex of v #
                IF alt < dists[v]
                THEN
                    dists[v] := alt;
                    prevs[v] := u
                FI
            FI
        OD
    OD;

    DIJKSTRA_RESULT(dists, prevs)
);

PROC min distance = (REF []INT dists, REF []INT q) INT:
(
    INT min dist := max int;
    INT min index;
    FOR v TO UPB dists
    DO
        IF q[v] > 0 AND dists[v] < min dist
        THEN
            min dist := dists[v];
            min index := v
        FI
    OD;

    min index
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINTLIST_RESULT list result := parse int list(s);
REF []INT weights := values OF list result;
INT num weights := UPB weights;
IF NOT valid OF list result
THEN
    usage;
    stop
FI;

# Parse 2nd command-line argument #
s := argv(5);
PARSEINT_RESULT result := parse int(s);
INT src := value OF result;
IF NOT valid OF result
THEN
    usage;
    stop
FI;

# Parse 3rd command-line argument #
s := argv(6);
result := parse int(s);
INT dest := value OF result;
IF NOT valid OF result
THEN
    usage;
    stop
FI;

# Validate inputs #
INT num vertices := ENTIER(sqrt(num weights) + 0.5);
IF NOT validate inputs(weights, num vertices, src, dest)
THEN
    usage;
    stop
FI;

# Create graph from weights #
GRAPH graph := create graph(num vertices, weights);

# Run Dijkstra's algorithm on graph and show distance to destination #
DIJKSTRA_RESULT dijkstra result = dijkstra(graph, src);
INT dist := (dists OF dijkstra result)[dest + 1];
printf(($gl$, whole(dist, 0)))
