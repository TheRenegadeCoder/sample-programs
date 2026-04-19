begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide three inputs: a serialized matrix, "
            "a source node and a destination node\n"
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
            - invalid byte maps 0;
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

    boolean procedure validateInputs(weights, numWeights, src, dest, numVertices);
    value numWeights, src, dest, numVertices;
    integer array weights;
    integer numWeights, src, dest, numVertices;
    begin
        boolean valid, anyNonZero;
        integer i;

        valid := true;

        comment Validate number of weights and source and destination node;
        if (numWeights != numVertices * numVertices |
            src < 0 | src >= numVertices | dest < 0 | dest >= numVertices)
            then valid := false;

        comment Verify weights greater than equal to zero and any non-zero
            weights;
        anyNonZero := false;
        i := 0;
    weightLoop:
        i := i + 1;
        if valid & i <= numWeights then
        begin
            if weights[i] > 0 then anyNonZero := true
            else if weights[i] < 0 then valid := false;
            goto weightLoop
        end;

        if !anyNonZero then valid := false;

        validateInputs := valid
    end validateInputs;

    comment Create graph from weights.
        The graph is in this form:
        - column 1: Number of edges for each node
        - column 2, 4, ..., 2*n: Index of each child node
        - column 3, 5, ..., 2*n+1: Weight of each child node
        
        where n = number of vertices;
    procedure createGraph(graph, weights, numVertices);
    value numVertices;
    integer array graph, weights;
    integer numVertices;
    begin
        integer u, v, idx, numEdges;

        idx := 0;
        for u := 1 step 1 until numVertices do
        begin
            comment Initialize number of edges for this node;
            numEdges := 0;

            for v := 1 step 1 until numVertices do
            begin
                idx := idx + 1;
                if weights[idx] > 0 then
                begin
                    comment Update number of edges, store child index and
                        weight;
                    numEdges := numEdges + 1;
                    graph[u, 2 * numEdges] := v;
                    graph[u, 2 * numEdges + 1] := weights[idx]
                end
            end;

            comment Store number of edges for this node;
            graph[u, 1] := numEdges
        end
    end createGraph;

    comment Dijkstra's algorithm
        Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode.

        Returns distances from source node to each node;
    procedure dijkstra(graph, numVertices, dists);
    value numVertices;
    integer array graph, dists;
    integer numVertices;
    begin
        integer procedure minDistance(q);
        boolean array q;
        begin
            integer minDist, minIndex, v;

            minDist := maxint;
            minIndex := 0;
            for v := 1 step 1 until numVertices do
            begin
                if dists[v] < minDist & q[v] then
                begin
                    minDist := dists[v];
                    minIndex := v
                end
            end;

            minDistance := minIndex
        end minDistance;

        integer idx, u, v, w, alt, numUnvisited;
        boolean array q[1:numVertices];

        comment Initialize distances to infinite and indicate all node are
            unvisited;
        numUnvisited := numVertices;
        for v := 1 step 1 until numVertices do
        begin
            dists[v] := maxint;
            q[v] := true
        end;

        comment Set distance to source node to 0;
        dists[src + 1] := 0;

        comment While any unvisited nodes,;
    qloop:
        if numUnvisited > 0 then
        begin
            comment Pick a vertex u in Q with minimum distance;
            u := minDistance(q);

            comment Remove vertex u from Q;
            if q[u] then numUnvisited := numUnvisited - 1;
            q[u] := false;

            comment For each neighbor v of vertex u in still in Q;
            for idx := 1 step 1 until graph[u, 1] do
            begin
                v := graph[u, idx * 2];
                if q[v] then
                begin
                    comment Get trial distance;
                    w := graph[u, idx * 2 + 1];
                    alt := dists[u] + w;

                    comment If trial distance is smaller than distance v,
                        update distance to v;
                    if alt < dists[v] then dists[v] := alt
                end
            end;

            goto qloop
        end
    end dijkstra;

    integer argc, ch, src, dest, numWeights, numVertices, result;
    integer array weights[1:1024];
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 3 then usage;

    comment Get weights from 1st argument. Exit if invalid;
    numWeights := inIntegerArray(weights, 1024);
    if numWeights < 1 then usage;

    comment Get source node from 2nd argument. Exit if invalid;
    if !inValidInteger(src, ch, false) then usage;

    comment Get destination node from 3rd argument. Exit if invalid;
    if !inValidInteger(dest, ch, false) then usage;

    comment Validate inputs. Exit if invalid;
    numVertices := sqrt(numWeights);
    if !validateInputs(weights, numWeights, src, dest, numVertices) then usage;

    begin
        comment Create graph based on weights;
        integer array graph[1:numVertices, 1:2 * numVertices + 1];
        integer array dists[1:numVertices];
        createGraph(graph, weights, numVertices);

        comment Run Dijkstra's algorithm on graph and show distance to
            destination;
        dijkstra(graph, numVertices, dists);
        outinteger(1, dists[dest + 1])
    end
end
