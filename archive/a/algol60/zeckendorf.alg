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
            - invalid byte maps to 0;
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

    comment Number of Fibonacci numbers before the math overflows;
    integer procedure maxfibs;
    begin
        maxfibs := 43
    end maxfibs;

    integer procedure fibonacciUpTo(n, fibs);
    value n;
    integer n;
    integer array fibs;
    begin
        integer a, b, c, idx;

        a := 1;
        b := 2;
        idx := 0;
    fibloop:
        if a <= n & idx < maxfibs then
        begin
            idx := idx + 1;
            fibs[idx] := a;
            c := a + b;
            a := b;
            b := c;
            goto fibloop
        end;
        fibonacciUpTo := idx
    end fibonacciUpTo;

    integer procedure zeckendorf(n, zecks);
    value n;
    integer n;
    integer array zecks;
    begin
        integer numFibs, fibIdx, zeckIdx, fib;
        integer array fibs[1:maxfibs];

        comment Get Fibonacci numbers up to and including n;
        numFibs := fibonacciUpTo(n, fibs);

        comment Going from largest to smallest, repeat until no more Fibonacci numbers
            left or sum of Fibonacci numbers is equal to n;
        fibIdx := numFibs;
        zeckIdx := 0;
    zeckloop:
        if fibIdx > 0 & n > 0 then
        begin
            comment If this Fibonacci number is less than or equal to n, use it and skip the
                previous Fibonacci number. Otherwise, go to previous Fibonacci number;
            fib := fibs[fibIdx];
            if fib <= n then
            begin
                zeckIdx := zeckIdx + 1;
                zecks[zeckIdx] := fib;
                fibIdx := fibIdx - 2;
                n := n - fib
            end
            else fibIdx := fibIdx - 1;
            goto zeckloop
        end;

        zeckendorf := zeckIdx
    end zeckendorf;

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

    integer argc, result, ch, numZecks;

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get integer value from 1st argument. Exit if invalid or
        negative;
    if !inValidInteger(result, ch) | result < 0 then usage;

    begin
        comment Output Zeckendorf values;
        integer array zecks[1:(maxfibs + 1) % 2];
        numZecks := zeckendorf(result, zecks);
        outIntegerArray(zecks, numZecks)
    end
end
