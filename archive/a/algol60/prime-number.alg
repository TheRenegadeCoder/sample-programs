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
        - comma maps to 13
        - null byte maps to -1
        - invalid bytes map to -2;
    integer procedure indigit;
    begin
        comment Mapping:
            - "0" to "9" maps to 1 to 10
            - "+" maps to 11
            - "-" maps to 12
            - "," mapps to 13
            - "\t" maps to 14
            - "\r" maps to 15
            - "\n" maps to 16
            - " " maps to 17
            - null byte maps to 18
            - invalid byte maps 0;
        integer ch;
        inchar(0, "0123456789+-,\t\r\n ", ch);
        if ch < 1 then ch := -2
        else if ch < 14 then ch := ch - 1
        else if ch < 18 then ch := 12
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
        ch := indigit;
        for ch := ch while ch = 12 do ch := indigit;

        comment Process signs: ignore "+" and invert sign if "-";
    signloop:
        if ch = 10 | ch = 11 then
        begin
            if ch = 11 then s := -s;
            ch := indigit;
            goto signloop
        end;

        comment Process digits: update value;
    valueloop:
        if ch >= 0 & ch <= 9 then
        begin
            comment Invalid if overflow or underflow;
            valid := false;
            if (s > 0 & (maxint - ch) % 10 < result) |
                (s < 0 & (-1 - maxint + ch) % 10 > result) then goto done;

            result := result * 10 + s * ch;
            ch := indigit;
            valid := true;
            goto valueloop
        end;

        comment Ignore whitespace;
        for ch := ch while ch = 12 do ch := indigit;

    done:
        inValidInteger := valid
    end inValidInteger;

    integer procedure mod(x, n);
    value x, n;
    integer x, n;
    begin
        mod := x - n * (x % n)
    end mod;

    boolean procedure isprime(x);
    value x;
    integer x;
    begin
        boolean result;
        integer i, q;

        result := x = 2 | (x > 2 & mod(x, 2) != 0);
        if result then
        begin
            q := entier(sqrt(x));
            for i := 3, i + 2 while result & i <= q do
            begin
                result := mod(x, i) != 0
            end
        end;

        isprime := result
    end isprime;

    integer argc, result, ch;

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get integer value from 1st argument. Exit if invalid, not
        end of argument, or negative;
    if !inValidInteger(result, ch) | ch != -1 | result < 0 then usage;

    comment Output "prime" if number is prime, "composite" otherwise;
    if isprime(result) then outstring(1, "prime")
    else outstring(1, "composite")
end
