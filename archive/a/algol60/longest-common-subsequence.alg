begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide two lists in the format "
            "\"1, 2, 3, 4, 5\"\n"
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

    integer procedure max(a, b);
    value a, b;
    integer a, b;
    begin
        max := if a > b then a else b
    end max;

    comment Source
        https://en.wikipedia.org/wiki/Longest_common_subsequence#
        Code_for_the_dynamic_programming_solution;
    procedure lcs(x, m, y, n, result, resultLen);
    value m, n;
    integer array x, y, result;
    integer m, n, resultLen;
    begin
        procedure backtrack(c, i, j);
        value i, j;
        integer array c;
        integer i, j;
        begin
            if i != 0 & j != 0 then
            begin
                if x[i] = y[j] then
                begin
                    result[c[i, j]] := x[i];
                    backtrack(c, i - 1, j - 1);
                end
                else if c[i, j - 1] > c[i - 1, j] then backtrack(c, i, j - 1)
                else backtrack(c, i - 1, j)
            end
        end backtrack;

        integer i, j;
        integer array c[0:m, 0:n];

        for i := 0 step 1 until m do c[i, 0] := 0;
        for j := 0 step 1 until n do c[0, j] := 0;
        for i := 1 step 1 until m do
        begin
            for j := 1 step 1 until n do
            begin
                if x[i] = y[j] then c[i, j] := c[i - 1, j - 1] + 1
                else c[i, j] := max(c[i, j - 1], c[i - 1, j])
            end
        end;

        resultLen := c[m, n];
        backtrack(c, m, n)
    end lcs;

    integer argc, list1Len, list2Len, resultLen;
    integer array list1[1:100], list2[1:100], result[1:100];
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 2 then usage;

    comment Get list 1 from 1st argument. Exit if invalid;
    list1Len := inIntegerArray(list1, 100);
    if list1Len < 1 then usage;

    comment Get list 2 from 2nd argument. Exit if invalid;
    list2Len := inIntegerArray(list2, 100);
    if list2Len < 1 then usage;

    comment Find longest command subsequence and output result;
    lcs(list1, list1Len, list2, list2Len, result, resultLen);
    outIntegerArray(result, resultLen)
end
