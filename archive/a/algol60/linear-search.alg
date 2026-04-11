begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") "
            "and the integer to find (\"11\")\n"
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

    integer procedure linearSearch(arr, arrLen, target);
    value arrLen, target;
    integer array arr;
    integer arrLen, target;
    begin
        integer idx, i;

        idx := -1;
        i := 1;
    searchloop:
        if i <= arrLen then
        begin
            if arr[i] = target then idx := i
            else
            begin
                i := i + 1;
                goto searchloop
            end
        end;

        linearSearch := idx
    end linearSearch;

    integer argc, arrLen, ch, target, idx;
    integer array arr[1:100];
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 2 then usage;

    comment Get list input from 1st argument. Exit if invalid;
    arrLen := inIntegerArray(arr, 100);
    if arrLen < 1 then usage;

    comment Get target value from 2nd argument. Exit if invalid;
    if !inValidInteger(target, ch, false) then usage;

    comment Linear search for target value in list. Indicate if found;
    idx := linearSearch(arr, arrLen, target);
    if idx > 0 then outstring(1, "true\n")
    else outstring(1, "false\n")
end
