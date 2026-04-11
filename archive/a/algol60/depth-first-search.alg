begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide a tree in an adjacency matrix form "
            "(\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") "
            "together with a list of vertex values (\"1, 3, 5, 2, 4\") "
            "and the integer to find (\"4\")"
        );
        stop
    end usage;

    comment Input a digit character from stdin and return the following:
        - "0" to "9" maps to 0 to 9
        - "+" maps to 10
        - "-" maps to 11
        - whitespace maps to 12
        - comma maps to 13
        - null byte maps to -1
        - invalid bytes map to -2;
    integer procedure indigit;
    begin
        comment Mapping:
            - "0" to "9" maps to 1 to 10
            - "+" maps to 11
            - "-" maps to 12
            - "\t" maps to 13
            - "\r" maps to 14
            - "\n" maps to 15
            - " " maps to 16
            - "," maps to 17
            - null byte maps to 18
            - invalid byte maps to 0;
        integer ch;
        inchar(0, "0123456789+-\t\r\n ,", ch);
        if ch < 1 then ch := -2
        else if ch < 13 then ch := ch - 1
        else if ch < 17 then ch := 12
        else if ch = 17 then ch := 13
        else ch := -1;
        indigit := ch
    end indigit;

    comment Input an integer from stdin into 'result' and parse it.
        The last character is read into 'ch'.
        return true if integer is valid, false otherwise;
    boolean procedure inValidInteger(result, ch, allowComma);
    value allowComma;
    integer result, ch;
    boolean allowComma;
    begin
        boolean valid, commaFound;
        integer s;

        result := 0;
        valid := false;
        commaFound := false;
        s := 1;

        comment Ignore whitespace;
    whiteloop:
        ch := indigit;
        if ch = 12 then goto whiteloop;

        comment Process signs: ignore "+" and invert sign if "-";
    signloop:
        if ch = 10 | ch = 11 then
        begin
            if ch = 11 then s := -s;
            ch := indigit;
            goto signloop
        end;

        comment Indicate valid if "0" to "9";
        if ch >= 0 & ch <= 9 then valid := true;

        comment Process digits: update value;
    valueloop:
        if ch >= 0 & ch <= 9 then
        begin
            comment Invalid if overflow or underflow;
            if (s > 0 & (maxint - ch) % 10 < result) |
                (s < 0 & (-1 - maxint + ch) % 10 > result) then valid := false;
            
            result := result * 10 + s * ch;
            ch := indigit;
            goto valueloop
        end;

        comment If comma not allowed, ignore characters until end
            input. If comma allowed, ignore characters until comma
            or end of input. Indicate if comma found;
    ignoreloop:
        if !(ch = -1 | (allowComma & ch = 13)) then
        begin
            if ch != 12 & ch != 13 then valid := false;
            if ch = 13 then
            begin
                commaFound := true;
                if !allowComma then valid := false
            end;

            ch := indigit;
            goto ignoreloop
        end;

        comment If comma found, indicate last character is comma;
        if commaFound then ch := 13;

        inValidInteger := valid
    end inValidInteger;

    comment Returns length of array if valid, -1 otherwise;
    integer procedure inIntegerArray(arr, maxLen);
    value maxLen;
    integer array arr;
    integer maxLen;
    begin
        integer arrLen, val, ch;
        boolean valid;

        arrLen := 0;

        comment Get value with possible comma (13). Indicate invalid,
            if invalid integer. Otherwise, append value to array if
            no invalid values and there is room;
    itemloop:
        if !inValidInteger(val, ch, true) then arrLen := -1
        else if arrLen >= 0 & arrLen < maxLen then
        begin
            arrLen := arrLen + 1;
            arr[arrLen] := val
        end;

        comment Repeat until end of input;
        if ch != -1 then goto itemloop;

        inIntegerArray := arrLen
    end inIntegerArray;

    comment Create graph from connection matrix and vertex values.
        The graph is in this form:
        - column 1: Vertex values
        - column 2: Number of children for each vertex value
        - column 3 ... n + 2: Index of each child
        
        where n = number of vertices;
    procedure createGraph(connMtx, connMtxLen, vert, vertLen, graph);
    value connMtxLen, vertLen;
    integer array connMtx, vert, graph;
    integer connMtxLen, vertLen;
    begin
        integer i, j, idx;

        idx := 0;
        for i := 1 step 1 until vertLen do
        begin
            comment Store this vertex value and initialize number of children;
            graph[i, 1] := vert[i];
            graph[i, 2] := 0;

            comment Connect child nodes for this vertex;
            for j := 1 step 1 until vertLen do
            begin
                idx := idx + 1;
                if idx <= connMtxLen then
                begin
                    if connMtx[idx] != 0 then
                    begin
                        graph[i, 2] := graph[i, 2] + 1;
                        graph[i, graph[i, 2] + 2] := j
                    end
                end
            end
        end
    end createGraph;

    comment Returns index if target value found, 0 otherwise;
    integer procedure depthFirstSearch(graph, vertLen, target);
    value vertLen, target;
    integer array graph;
    integer vertLen, target;
    begin
        integer procedure depthFirstSearchRec(visited, nodeIdx);
        value nodeIdx;
        boolean array visited;
        integer nodeIdx;
        begin
            integer foundIdx, childIdx, i;

            comment Indicate target value not found;
            foundIdx := 0;

            comment If node index is valid and value matches target, return
                this node index;
            if nodeIdx > 0 then
            begin
                if graph[nodeIdx, 1] = target then foundIdx := nodeIdx
                else
                begin
                    comment Otherwise, indicate node is visited;
                    visited[nodeIdx] := true;

                    comment Perform Depth First Search on each unvisited child of
                        this node (if any). Stop when target value is found;
                    i := 0;
                searchloop:
                    i := i + 1;
                    if i <= graph[nodeIdx, 2] & foundIdx = 0 then
                    begin
                        childIdx := graph[nodeIdx, i + 2];
                        if !visited[childIdx] then
                        begin
                            foundIdx := depthFirstSearchRec(visited, childIdx);
                            visited[childIdx] := true
                        end;

                        goto searchloop
                    end
                end
            end;

            depthFirstSearchRec := foundIdx
        end depthFirstSearchRec;

        integer i;
        boolean array visited[1:vertLen];

        comment Indicate no nodes visited;
        for i := 1 step 1 until vertLen do visited[i] := false;

        comment Do Depth First Search for target value starting at
            root node (1);
        depthFirstSearch := depthFirstSearchRec(visited, 1)
    end depthFirstSearch;

    integer argc, connMtxLen, vertLen, ch, target, idx;
    integer array connMtx[1:256], vert[1:16];
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 3 then usage;

    comment Get connection matrix input from 1st argument. Exit if invalid;
    connMtxLen := inIntegerArray(connMtx, 256);
    if connMtxLen < 1 then usage;

    comment Get vertex values from 2nd argument. Exit if invalid;
    vertLen := inIntegerArray(vert, 16);
    if vertLen < 1 then usage;

    comment Get target value from 3nd argument. Exit if invalid;
    if !inValidInteger(target, ch, false) then usage;

    begin
        comment Create a graph from the connect matrix and vertex values;
        integer array graph[1:vertLen, 1:vertLen + 2];
        createGraph(connMtx, connMtxLen, vert, vertLen, graph);

        comment Depth First Search for target value. Indicate if found;
        idx := depthFirstSearch(graph, vertLen, target);
        if idx > 0 then outstring(1, "true\n")
        else outstring(1, "false\n")
    end
end
