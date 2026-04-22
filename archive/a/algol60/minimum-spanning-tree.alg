begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide a comma-separated list of integers\n"
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

    comment Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
    https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/.
    Returns matrix in following format:
    - Column 1: Parent node indices
    - Column 2: Target node indices
    - Column 3: Weights;
    procedure primMst(graph, numVertices, mstResult);
    value numVertices;
    integer array graph, mstResult;
    integer numVertices;
    begin
        comment Find vertex with minimum key values not already in MST;
        integer procedure findMinKey(keys, mstSet);
        integer array keys;
        boolean array mstSet;
        begin
            integer minValue, minIndex, v;

            minValue := maxint;
            minIndex := 0;
            for v := 1 step 1 until numVertices do
            begin
                if !mstSet[v] & keys[v] < minValue then
                begin
                    minValue := keys[v];
                    minIndex := v
                end
            end;

            findMinKey := minIndex
        end findMinKey;

        integer array parents[1:numVertices], keys[1:numVertices];
        boolean array mstSet[1:numVertices];
        integer i, j, u, v, w;

        comment Initialize key values to infinite and indicate nothing is in
            MST yet;
        for i := 1 step 1 until numVertices do
        begin
            keys[i] := maxint;
            mstSet[i] := false
        end;

        comment Include first vertex in MST, and root has no parent;
        keys[1] := 0;
        parents[1] := 0;

        for i := 1 step 1 until numVertices - 1 do
        begin
            comment Pick index of the minimum key value not already in MST;
            u := findMinKey(keys, mstSet);

            comment Add picked vertex to MST set;
            mstSet[u] := true;

            comment Update key values and parent indices of picked adjacent
                vertices. Only consider vertices not yet in MST;
            for j := 1 step 1 until graph[u, 1] do
            begin
                v := graph[u, j * 2];
                w := graph[u, j * 2 + 1];
                if !mstSet[v] & w < keys[v] then
                begin
                    parents[v] := u;
                    keys[v] := w
                end
            end
        end;

        comment Store MST results, skipping over root and adjusting vertex
            numbers to account for 1-based indexing;
        for i := 2 step 1 until numVertices do
        begin
            mstResult[i - 1, 1] := parents[i] - 1;
            mstResult[i - 1, 2] := i - 1;
            mstResult[i - 1, 3] := keys[i]
        end
    end primMst;

    integer procedure getTotalMstWeight(mstResult, numResults);
    value numResults;
    integer array mstResult;
    integer numResults;
    begin
        integer total, i;

        total := 0;
        for i := 1 step 1 until numResults do total := total + mstResult[i, 3];

        getTotalMstWeight := total
    end getTotalMstWeight;

    integer argc, ch, src,  dest, numWeights, numVertices;
    integer array weights[1:1024];
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get weights from 1st argument. Exit if invalid;
    numWeights := inIntegerArray(weights, 1024);
    if numWeights < 1 then usage;

    comment Validate inputs. Exit if invalid;
    numVertices := sqrt(numWeights);
    if numWeights != numVertices * numVertices then usage;

    begin
        comment Create graph based on weights;
        integer array graph[1:numVertices, 1:2 * numVertices + 1];
        integer array mstResult[1:numVertices - 1, 1:3];
        integer total;
        createGraph(graph, weights, numVertices);

        comment Get MST using Prim's algorithm;
        primMst(graph, numVertices, mstResult);

        comment Get total weight and output result;
        total := getTotalMstWeight(mstResult, numVertices - 1);
        outinteger(1, total);
        outstring(1, "\n")
    end
end
