begin
    procedure usage;
    begin
        outstring(1, "Usage: please input the count of fibonacci numbers to output\n");
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
        for ch := indigit while ch = 12 do;

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

    comment Output integer without space. This is needed since ALGOL60
        'outinteger' automatically adds a space after the integer;
    procedure outIntegerNoSpace(x);
    value x;
    integer x;
    begin
        integer d;
        if x < 0 then outstring(1, "-");

        comment Find highest power of 10 for input value;
        d := 1;
    powerloop:
        if abs(x % d) > 9 then
        begin
            d := d * 10;
            goto powerloop
        end;

        comment Output each digit of value starting with the leftmost digit;
    outputloop:
        if d > 0 then
        begin
            outchar(1, "0123456789", abs(x % d) + 1);
            x := abs(mod(x, d));
            d := d % 10;
            goto outputloop
        end
    end outIntegerNoSpace;

    procedure fibonacci(n);
    value n;
    integer n;
    begin
        integer a, b, c, i;

        a := 0;
        b := 1;
        for i := 1 step 1 until n do
        begin
            c := a + b;
            a := b;
            b := c;
            outIntegerNoSpace(i);
            outstring(1, ": ");
            outIntegerNoSpace(a);
            outstring(1, "\n");
        end
    end fibonacci;

    integer argc, result, ch;

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get integer value from 1st argument. Exit if invalid, not
        end of argument, or negative;
    if !inValidInteger(result, ch) | ch != -1 | result < 0 then usage;

    comment Output Fibonacci values;
    fibonacci(result);
end
