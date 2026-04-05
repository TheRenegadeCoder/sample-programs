begin
    procedure usage;
    begin
        outstring(1, "Usage: please input the total number of people and number of people to skip.\n");
        stop
    end usage;

    comment Input a digit character from stdin and return the following:
        - "0" to "9" maps to 0 to 9
        - "+" maps to 10
        - "-" maps to 11
        - comma maps to 12
        - whitespace maps to 13
        - null byte maps to -1
        - invalid bytes map to -2;
    integer procedure indigit;
    begin
        comment Mapping:
            - "0" to "9" maps to 1 to 10
            - "+" maps to 11
            - "-" maps to 12
            - "," maps to 13
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
        else if ch < 18 then ch := 13
        else ch := -1;
        indigit := ch
    end indigit;

    procedure ignoreWhitespace(ch);
    integer ch;
    begin
    whiteloop:
        if ch = 13 then
        begin
            ch := indigit;
            goto whiteloop
        end
    end ignoreWhitespace;

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
        ignoreWhitespace(ch);

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
            valid := true;
            if (s > 0 & (maxint - ch) % 10 < result) |
                (s < 0 & (-1 - maxint + ch) % 10 > result) then valid := false
            else result := result * 10 + s * ch;

            ch := indigit;
            goto valueloop
        end;

        comment Ignore whitespace;
        ignoreWhitespace(ch);

        inValidInteger := valid
    end inValidInteger;

    integer procedure mod(x, n);
    value x, n;
    integer x, n;
    begin
        mod := x - n * (x % n)
    end mod;

    comment Reference: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case;
    integer procedure josephusProblem(n, k);
    value n, k;
    integer n, k;
    begin
        integer m, g;

        g := 0;
        for m := 2 step 1 until n do
        begin
            g := mod(g + k, m)
        end;

        josephusProblem := g + 1
    end josephusProblem;

    integer argc, n, k, g, ch;

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 2 then usage;

    comment Get integer value from 1st argument (n). Exit if invalid or not
        end of argument;
    if !inValidInteger(n, ch) | ch != -1 then usage;

    comment Get integer value from 2nd argument (k). Exit if invalid or not
        end of argument;
    if !inValidInteger(k, ch) | ch != -1 then usage;

    comment Output Josephus Problem result;
    g := josephusProblem(n, k);
    outinteger(1, g);
    outstring(1, "\n")
end
