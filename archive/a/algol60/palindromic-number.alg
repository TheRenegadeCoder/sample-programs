begin
    procedure usage;
    begin
        outstring(1, "Usage: please input a non-negative integer\n");
        stop
    end usage;

    comment Input a digit character from stdin and return the following:
        - "0" to "9" maps to 0 to 9
        - "+" maps to 10
        - "-" maps to 11
        - whitespace maps to 12
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
            - null byte maps to 17
            - invalid byte maps 0;
        integer ch;
        inchar(0, "0123456789+-\t\r\n ", ch);
        if ch < 1 then ch := -2
        else if ch < 13 then ch := ch - 1
        else if ch < 17 then ch := 12
        else ch := -1;
        indigit := ch
    end indigit;

    comment Input an integer from stdin into 'result' and parse it.
        The last character is read into 'ch'.
        return true if integer is valid, false otherwise;
    boolean procedure inValidInteger(result, ch);
    integer result, ch;
    begin
        boolean valid;
        integer s;

        result := 0;
        valid := false;
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

        comment Ignore characters until end of argument. Indicate invalid
            if not whitespace;
    ignoreloop:
        if ch != -1 then
        begin
            if ch != 12 then valid := false;
            ch := indigit;
            goto ignoreloop
        end;

        inValidInteger := valid
    end inValidInteger;

    integer procedure mod(x, n);
    value x, n;
    integer x, n;
    begin
        mod := x - n * (x % n)
    end mod;

    boolean procedure isPalindromicNumber(x);
    value x;
    integer x;
    begin
        integer xrev, temp;

        comment Reverse the passed in value;
        xrev := 0;
        for temp := x, temp % 10 while temp > 0 do
            xrev := xrev * 10 + mod(temp, 10);

        isPalindromicNumber := x = xrev
    end isPalindromicNumber;

    integer argc, result, ch;

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get integer value from 1st argument. Exit if invalid or
        negative;
    if !inValidInteger(result, ch) | result < 0 then usage;

    comment Output "true" if number is palindromic number, "false" otherwise;
    if isPalindromicNumber(result) then outstring(1, "true")
    else outstring(1, "false")
end
