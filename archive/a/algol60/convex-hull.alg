begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide at least 3 x and y coordinates as separate "
            "lists (e.g. \"100, 440, 210\")\n"
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

    comment Output integer without space. This is needed since ALGOL60
        'outinteger' automatically adds a space after the integer.
        Source: 'outinteger' function source code in Appendix 2 of
        https://www.algol60.org/reports/algol60_mr.pdf;
    procedure outIntegerNoSpace(x);
    value x;
    integer x;
    begin
        procedure digits(x);
        value x;
        integer x;
        begin
            integer d;
            d := x % 10;
            x := x - 10 * d;
            if d != 0 then digits(d);
            outchar(1, "0123456789", iabs(x) + 1)
        end digits;
        if x < 0 then outstring(1, "-");
        digits(x)
    end outIntegerNoSpace;

    comment Find Convex Hull using Jarvis' algorithm
        Source: https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/;
    integer procedure convexHull(xCoords, yCoords, n, hullX, hullY);
    value n;
    integer array xCoords, yCoords, hullX, hullY;
    integer n;
    begin
        integer procedure findLeftmostPoint;
        begin
            integer i, minIndex, minX, maxY, x, y;

            minIndex := 1;
            minX := maxint;
            maxY := -maxint - 1;
            for i := 1 step 1 until n do
            begin
                comment In the event of a tie, pick the point with the greater
                    y-coord;
                x := xCoords[i];
                y := yCoords[i];
                if x < minX | (x = minX & y > maxY) then
                begin
                    minX := x;
                    maxY := y;
                    minIndex := i
                end
            end;

            findLeftmostPoint := minIndex
        end findLeftmostPoint;

        comment Get orientation of three points:
        - zero: points are in a line
        - negative: points are counter-clockwise
        - positive: points are clockwise;
        integer procedure orientation(p, q, r);
        value p, q, r;
        integer p, q, r;
        begin
            orientation :=
                (yCoords[q] - yCoords[p]) * (xCoords[r] - xCoords[q]) -
                (xCoords[q] - xCoords[p]) * (yCoords[r] - yCoords[q])
        end orientation;

        integer i, j, l, p, q;

        comment The first point is the leftmost point with the highest y-coord
            in the event of a tie;
        l := findLeftmostPoint;
        p := l;
        i := 0;

        comment Repeat until wrapped around to first hull point
            Store convex hull point;
    hloop:
        i := i + 1;
        hullX[i] := xCoords[p];
        hullY[i] := yCoords[p];

        q := 1 + p - n * (p % n);
        for j := 1 step 1 until n do
        begin
            comment If point j is more counter-clockwise, then update end point
                (q);
            if orientation(p, j, q) < 0 then q := j
        end;

        p := q;
        if p != l then goto hloop;

        convexHull := i
    end convexHull;

    procedure outputPoints(xCoords, yCoords, numPoints);
    value numPoints;
    integer array xCoords, yCoords;
    integer numPoints;
    begin
        integer i;

        for i := 1 step 1 until numPoints do
        begin
            outstring(1, "(");
            outIntegerNoSpace(xCoords[i]);
            outstring(1, ", ");
            outIntegerNoSpace(yCoords[i]);
            outstring(1, ")");
            outstring(1, "\n")
        end
    end outputPoints;

    integer argc, n;
    integer array xCoords[1:100], yCoords[1:100];
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 2 then usage;

    comment Get X-coordinates from 1st argument. Exit if invalid;
    n := inIntegerArray(xCoords, 100);
    if n < 3 then usage;

    comment Get Y-coordinates from 1st argument. Exit if invalid;
    if inIntegerArray(yCoords, n + 1) != n then usage;

    comment Get convex hull of points and output points;
    begin
        integer array hullX[1:n], hullY[1:n];
        integer numHullPoints;
        numHullPoints := convexHull(xCoords, yCoords, n, hullX, hullY);
        outputPoints(hullX, hullY, numHullPoints)
    end
end
