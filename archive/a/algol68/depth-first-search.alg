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
    printf(($gl$, "Usage: please provide a tree in an adjacency matrix form (""0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0"") together with a list of vertex values (""1, 3, 5, 2, 4"") and the integer to find (""4"")"))
);

COMMENT
Algol68 doesn't have associative arrays, so I had to create one.
The basic principle is to have an hash table, where this index is
(value - 1) MOD size + 1, and size is a prime number. I chose
257 as an example. The contents of a hash table element is a
value and a linked list of values that hash to the same value.
Example, for values, 1, 2, and 258, the hash table would look
like this:
- 1: 1 -> 258 -> NIL
- 2: 2 -> NIL
- 3: NIL
- ...
- 257: NIL
COMMENT
MODE NODE = STRUCT(INT key, REF []INT values);
REF []INT empty values = NIL;
OP ISEMPTY = (REF []INT values) BOOL: values IS empty values;
REF NODE empty node = NIL;
OP ISEMPTY = (REF NODE node) BOOL: node IS empty node;

INT hash table size := 257;
MODE HASHTABLE_ELEM = STRUCT(NODE node, HASHTABLE_ELEMREF next),
    HASHTABLE_ELEMREF = REF HASHTABLE_ELEM;
HASHTABLE_ELEMREF empty hash entry = NIL;
MODE HASHTABLE = [hash table size]HASHTABLE_ELEMREF;
OP ISEMPTY = (HASHTABLE_ELEMREF entry) BOOL: entry IS empty hash entry;
OP HASH = (INT value) INT: (value - 1) MOD hash table size + 1;
MODE HASHTABLE_FIND = STRUCT(BOOL found, INT hash, HASHTABLE_ELEMREF found entry);

PROC create hash table = REF HASHTABLE:
(
    # Allocate and initialize hash table #
    HEAP HASHTABLE hash table;
    FOR k TO hash table size
    DO
        hash table[k] := NIL
    OD;

    hash table
);

PROC add hash table entry = (REF HASHTABLE hash table, INT key, REF []INT values) REF NODE:
(
    # Find key in hash table #
    HASHTABLE_FIND find info := find hash table entry(hash table, key);
    HASHTABLE_ELEMREF last entry := found entry OF find info;
    REF NODE node := NIL;

    IF NOT (found OF find info)
    THEN
        # Create new hash table entry #
        HEAP HASHTABLE_ELEM entry := HASHTABLE_ELEM(NODE(key, values), NIL);
        node := node OF entry;

        # If not found and hash table entry is empty, add it to hash table #
        # Else, append it to existing entry #
        IF ISEMPTY last entry
        THEN
            hash table[hash OF find info] := entry
        ELSE
            next OF last entry := entry
        FI
    FI;

    node
);

PROC find hash table entry = (REF HASHTABLE hash table, INT key) HASHTABLE_FIND:
(
    INT hash := HASH key;
    HASHTABLE_ELEMREF entry := hash table[hash];
    BOOL found := FALSE;
    HASHTABLE_ELEMREF found entry := NIL;

    # If table entry found for hash, loop over table entries in this table entry #
    # until key found or last table entry #
    IF NOT ISEMPTY entry
    THEN
        WHILE NOT ISEMPTY entry AND NOT found
        DO
            found entry := entry;
            IF (key OF node OF entry) = key
            THEN
                found := TRUE
            ELSE
                entry := next OF entry
            FI
        OD
    FI;

    HASHTABLE_FIND(found, hash, found entry)
);

# Create tree based on adjacency matrix and vertex values #
MODE TREE = STRUCT(REF HASHTABLE hashtable, REF NODE root);
PROC create tree = (REF []INT adjacency matrix, REF []INT vertex values) TREE:
(
    # Create hash table #
    REF HASHTABLE hash table := create hash table;

    INT num vertices := UPB vertex values;
    INT num adjacencies := UPB adjacency matrix;


    INT k := 1;
    REF NODE root := NIL;
    REF NODE node;
    INT num connections;
    [num vertices]INT temp connections;
    FOR row TO num vertices
    DO
        # Get this vertex value #
        INT key := vertex values[row];

        # Get connections for this vertex value based on non-zero values of adjacency matrix #
        INT num connections := 0;
        FOR col TO num vertices
        WHILE k <= num adjacencies
        DO
            IF adjacency matrix[k] /= 0
            THEN
                num connections +:= 1;
                temp connections[num connections] := vertex values[col]
            FI;

            k +:= 1
        OD;

        REF []INT values := NIL;
        IF num connections > 0
        THEN
            values := HEAP [num connections] INT := temp connections[:num connections]
        FI;

        # Add node to tree #
        node := add hash table entry(hash table, key, values);

        # If no root, set root to this node #
        IF ISEMPTY root
        THEN
            root := node
        FI
    OD;

    TREE(hash table, root)
);

PROC depth first search = (TREE tree, INT target) REF NODE:
(
    # Initialize visit nodes #
    REF HASHTABLE visited = create hash table;

    # Perform depth first recursively starting at root of tree #
    REF NODE found := NIL;
    depth first search rec(hash table OF tree, root OF tree, target, visited, found)
);

PROC depth first search rec = (
    REF HASHTABLE hash table, REF NODE node, INT target, REF HASHTABLE visited, REF REF NODE found
) REF NODE:
(
    # If entry not found, #
    IF ISEMPTY found
    THEN
        INT key := key OF node;
        REF []INT values := values OF node;

        # Indicate this node is visited #
        add hash table entry(visited, key, NIL);

        # If key of this node matches target, indicate found #
        # Else, perform depth first search on each unvisited child of this node (if any) #
        IF key = target
        THEN
            found := node
        ELIF NOT ISEMPTY values
        THEN
            FOR k TO UPB values
            WHILE ISEMPTY found
            DO
                key := values[k];
                IF NOT (found OF find hash table entry(visited, key))
                THEN
                    node := node OF found entry OF find hash table entry(hash table, key);
                    found := depth first search rec(hash table, node, target, visited, found);
                    add hash table entry(visited, key, NIL)
                FI
            OD
        FI
    FI;

    found
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
TREE tree := create tree(adjacency matrix, vertex values);

# Run depth first search and indicate if value is found #
REF NODE node := depth first search(tree, value);
printf(($gl$, (ISEMPTY node | "false" | "true")))
