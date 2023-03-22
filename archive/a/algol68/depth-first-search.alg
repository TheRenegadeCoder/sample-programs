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
    printf((
        $gl$,
        (
            "Usage: please provide a tree in an adjacency matrix form "
            + "(""0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0"") "
            + "together with a list of vertex values (""1, 3, 5, 2, 4"") "
            + "and the integer to find (""4"")"
        )
    ))
);

COMMENT
Create tree from adjacency matrix and vertex values.
The tree consists of a sequence of nodes.
Each node consists of a vertex value and sequence of child indices
COMMENT
MODE NODE = STRUCT(INT value, REF []INT children);

PROC create tree = (REF []INT adjacency matrix, REF []INT vertex values) REF []NODE:
(
    # Initialize nodes #
    INT num vertices := UPB vertex values;
    HEAP [num vertices]NODE nodes;
    INT num adjacencies := UPB adjacency matrix;

    # Get children for this vertex value based on non-zero values of adjacency matrix #
    INT index := 0;
    FOR row TO num vertices
    DO
        # Count number of children #
        INT num children := 0;
        FOR col TO num vertices
        WHILE (index + col) < num adjacencies
        DO
            IF adjacency matrix[index + col] > 0
            THEN
                num children +:= 1
            FI
        OD;

        # Add child node indices to this node #
        HEAP [num children]INT children;
        num children := 0;
        FOR col TO num vertices
        WHILE index < num adjacencies
        DO
            index +:= 1;
            IF adjacency matrix[index] > 0
            THEN
                num children +:= 1;
                children[num children] := col
            FI
        OD;

        nodes[row] := NODE(vertex values[row], children)
    OD;

    nodes
);

PROC depth first search = (REF []NODE tree, INT target) REF NODE:
(
    # Initialize visit nodes #
    INT num vertices = UPB tree;
    HEAP [num vertices]BOOL visited;
    FOR k TO num vertices
    DO
        visited[k] := FALSE
    OD;

    # Perform depth first recursively starting at root of tree #
    INT found index := depth first search rec(tree, target, 1, visited);
    (found index > 0 | tree[found index] | NIL)
);

PROC depth first search rec = (
    REF []NODE tree, INT target, INT node index, REF []BOOL visited
) INT:
(
    INT found index := 0;

    # If node is invalid or value of this node matches target, return this node index #
    IF node index = 0 OREL value OF tree[node index] = target
    THEN
        found index := node index
    ELSE
        # Indicate this node is visited #
        visited[node index] := TRUE;

        # Perform depth first search on each unvisited child of this node (if any). #
        # Stop when match found #
        INT child index;
        REF []INT children := children OF tree[node index];
        FOR k TO UPB children
        WHILE found index = 0
        DO
            child index := children[k];
            IF NOT visited[child index]
            THEN
                found index := depth first search rec(tree, target, child index, visited);
                visited[child index] := TRUE
            FI
        OD
    FI;

    found index
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINTLIST_RESULT list result := parse int list(s);
REF []INT adjacency matrix := values OF list result;
IF NOT valid OF list result
THEN
    usage;
    stop
FI;

# Parse 2nd command-line argument #
s := argv(5);
list result := parse int list(s);
REF []INT vertex values = values OF list result;
IF NOT valid OF list result
THEN
    usage;
    stop
FI;

# Parse 3rd command-line argument #
s := argv(6);
PARSEINT_RESULT result := parse int(s);
INT value := value OF result;
IF NOT valid OF result
THEN
    usage;
    stop
FI;

# Create tree from adjacency matrix and vertex values #
REF []NODE tree := create tree(adjacency matrix, vertex values);

# Run depth first search and indicate if value is found #
REF NODE node := depth first search(tree, value);
printf(($gl$, (node ISNT REF NODE(NIL) | "true" | "false")))
