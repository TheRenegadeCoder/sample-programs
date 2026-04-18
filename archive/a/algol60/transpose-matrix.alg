begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please enter the dimension of the matrix and the "
            "serialized matrix\n"
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

    comment Output integer array;
    procedure outIntegerArray(arr, arrLen);
    value arrLen;
    integer array arr;
    integer arrLen;
    begin
        integer i;
        for i := 1 step 1 until arrLen do
        begin
            if i > 1 then outstring(1, ", ");
            outIntegerNoSpace(arr[i])
        end;

        if arrLen > 0 then outstring(1, "\n")
    end outIntegerArray;

    procedure arrayToMatrix(arr, numRows, numCols, mtx);
    value numRows, numCols;
    integer array arr, mtx;
    integer numRows, numCols;
    begin
        integer i, j, idx;

        idx := 0;
        for i := 1 step 1 until numRows do
        begin
            for j := 1 step 1 until numCols do
            begin
                idx := idx + 1;
                mtx[i, j] := arr[idx]
            end
        end
    end arrayToMatrix;

    procedure transposeMatrix(mtx, numRows, numCols, mtxT);
    value numRows, numCols;
    integer array mtx, mtxT;
    integer numRows, numCols;
    begin
        integer i, j;

        for i := 1 step 1 until numRows do
        begin
            for j := 1 step 1 until numCols do mtxT[j, i] := mtx[i, j]
        end
    end transposeMatrix;

    procedure matrixToArray(mtx, numRows, numCols, arr);
    value numRows, numCols;
    integer array mtx, arr;
    integer numRows, numCols;
    begin
        integer i, j, idx;

        idx := 0;
        for i := 1 step 1 until numRows do
        begin
            for j := 1 step 1 until numCols do
            begin
                idx := idx + 1;
                arr[idx] := mtx[i, j]
            end
        end
    end matrixToArray;

    integer argc, size, ch, numCols, numRows;
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 3 then usage;

    comment Get number of columns from 1st argument. Exit if invalid;
    if !inValidInteger(numCols, ch, false) then usage;

    comment Get number of rows from 2nd argument. Exit if invalid;
    if !inValidInteger(numRows, ch, false) then usage;

    comment Get total size of array;
    size := numRows * numCols;

    begin
        integer arrLen;
        integer array arr[1:size];
        integer array mtx[1:numRows, 1:numCols], mtxT[1:numCols, 1:numRows];

        comment Get array from 3rd argument. Exit if invalid or does not
            match expect size;
        arrLen := inIntegerArray(arr, size + 1);
        if arrLen != size then usage;

        comment Convert array to matrix;
        arrayToMatrix(arr, numRows, numCols, mtx);

        comment Transpose matrix;
        transposeMatrix(mtx, numRows, numCols, mtxT);

        comment Convert matrix to array and display;
        matrixToArray(mtxT, numCols, numRows, arr);
        outIntegerArray(arr, arrLen)
    end
end
