begin
    procedure usage;
    begin
        outstring(1, "Usage: ./fraction-math operand1 operator operand2\n");
        stop
    end usage;

    procedure error(errMsg);
    string errMsg;
    begin
        outstring(1, errMsg);
        outstring(1, "\n");
        stop
    end error;

    comment Input a digit character from stdin and return the following:
        - "0" to "9" maps to 0 to 9
        - "+" maps to 10
        - "-" maps to 11
        - whitespace maps to 12
        - slash maps to 13
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
            - "/" maps to 17
            - null byte maps to 18
            - invalid byte maps to 0;
        integer ch;
        inchar(0, "0123456789+-\t\r\n /", ch);
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
    boolean procedure inValidInteger(result, ch, allowSlash);
    value allowSlash;
    integer result, ch;
    boolean allowSlash;
    begin
        boolean valid, slashFound;
        integer s;

        result := 0;
        valid := false;
        slashFound := false;
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

        comment If slash not allowed, ignore characters until end
            input. If slash allowed, ignore characters until slash
            or end of input. Indicate if slash found;
    ignoreloop:
        if !(ch = -1 | (allowSlash & ch = 13)) then
        begin
            if ch != 12 & ch != 13 then valid := false;
            if ch = 13 then
            begin
                slashFound := true;
                if !allowSlash then valid := false
            end;

            ch := indigit;
            goto ignoreloop
        end;

        comment If slash found, indicate last character is slash;
        if slashFound then ch := 13;

        inValidInteger := valid
    end inValidInteger;

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

    comment Greatest common denominator using Euclidean algorithm
        Source: https://en.wikipedia.org/wiki/Euclidean_algorithm#Implementations;
    integer procedure gcd(a, b);
    value a, b;
    integer a, b;
    begin
        integer t;

        a := iabs(a);
        b := iabs(b);
    gloop:
        if b != 0 then
        begin
            t := b;
            b := a - b * (a % b);
            a := t;
            goto gloop
        end;

        gcd := a
    end gcd;

    procedure fractionReduce(n, d);
    integer n, d;
    begin
        integer g;

        comment Error if denominator is 0;
        if d = 0 then error("Divide by 0");

        comment If denominator is negative, negate numerator and denominator;
        if d < 0 then
        begin
            n := -n;
            d := -d
        end;

        comment Divide numerator and denominator by GCD;
        g := gcd(n, d);
        n := n / g;
        d := d / g
    end fractionReduce;

    boolean procedure inFraction(n, d);
    integer n, d;
    begin
        integer ch;
        boolean valid;

        comment Input numerator;
        valid := inValidInteger(n, ch, true);

        comment If valid and last character is slash (13), input denominator;
        d := 1;
        if valid & ch = 13 then valid := inValidInteger(d, ch, false);

        comment Indicate invalid if last character is not null byte;
        if valid & ch != -1 then valid := false;

        comment If valid, reduce fraction;
        if valid then fractionReduce(n, d);

        inFraction := valid
    end inFraction;

    comment Fraction addition and subtraction
        n1/d1 +/- n2/d2 = (n1*d2 +/- n2*d1) / (d1*d2);
    procedure fractionAdd(n1, d1, n2, d2, n, d);
    value n1, d1, n2, d2;
    integer n1, d1, n2, d2, n, d;
    begin
        n := n1 * d2 + n2 * d1;
        d := d1 * d2
    end fractionAdd;

    procedure fractionSub(n1, d1, n2, d2, n, d);
    value n1, d1, n2, d2;
    integer n1, d1, n2, d2, n, d;
    begin
        n := n1 * d2 - n2 * d1;
        d := d1 * d2
    end fractionSub;

    comment Fraction multiplication
        n1/d1 * n2/d2 = (n1*n2) / (d1*d2);
    procedure fractionMul(n1, d1, n2, d2, n, d);
    value n1, d1, n2, d2;
    integer n1, d1, n2, d2, n, d;
    begin
        n := n1 * n2;
        d := d1 * d2
    end fractionMul;

    comment Fraction division
        (n1/d1) / (n2/d2) = (n1*d2) / (n2*d1);
    procedure fractionDiv(n1, d1, n2, d2, n, d);
    value n1, d1, n2, d2;
    integer n1, d1, n2, d2, n, d;
    begin
        n := n1 * d2;
        d := n2 * d1
    end fractionDiv;

    comment Fraction comparison
        n1/d1 comp n2/d2 = n1*d2 comp n2*d1

        Returns:
        - -1 if n1/d1 < n2/d2
        - 0 if n1/d1 == n2/d2
        - 1 otherwise;
    integer procedure fractionComp(n1, d1, n2, d2);
    value n1, d1, n2, d2;
    integer n1, d1, n2, d2;
    begin
        fractionComp := sign(n1 * d2 - n2 * d1)
    end fractionComp;

    comment Decode operator:
        - "+" (43) maps to 1
        - "-" (45) maps to 2
        - "*" (42) maps to 3
        - "/" (47) maps to 4
        - "<" (60) maps to 5
        - ">" (62) maps to 6
        - "==" (61, 61) maps to 7
        - "<=" (60, 61) maps to 8
        - ">=" (62, 61) maps to 9
        - "!=" (33, 61) maps to 10
        - Invalid operator maps to 0;
    integer procedure parseOperator(opStr, opLen);
    value opLen;
    integer array opStr;
    integer opLen;
    begin
        integer op;

        comment Assume invalid operator;
        op := 0;

        comment If operator length is 1:
            - "+" (43) maps to 1
            - "-" (45) maps to 2
            - "*" (47) maps to 3
            - "/" (42) maps to 4
            - "<" (60) maps to 5
            - ">" (62) maps to 6;
        if opLen = 1 then
        begin
            if opStr[1] = 43 then op := 1
            else if opStr[1] = 45 then op := 2
            else if opStr[1] = 42 then op := 3
            else if opStr[1] = 47 then op := 4
            else if opStr[1] = 60 then op := 5
            else if opStr[1] = 62 then op := 6
        end
        else if opLen = 2 & opStr[2] = 61 then
        begin
            comment If operator length is 2 and 2nd character of operator
                is 61 (=), first character of operation:
                - "=" (61) maps to 7
                - "<" (60) maps to 8
                - ">" (62) maps to 9
                - "!" (33) maps to 10;
            if opStr[1] = 61 then op := 7
            else if opStr[1] = 60 then op := 8
            else if opStr[1] = 62 then op := 9
            else if opStr[1] = 33 then op := 10
        end;

        parseOperator := op
    end parseOperator;

    boolean procedure fractionMath(n1, d1, opStr, opLen, n2, d2, n, d);
    value n1, d1, n2, d2, opLen;
    integer n1, d1, opLen, n2, d2, n, d;
    integer array opStr;
    begin
        integer op;
        boolean isBool, boolResult;

        comment Parse operator. Error if invalid;
        op := parseOperator(opStr, opLen);
        if op < 1 then error("Invalid operator");

        comment Handle fraction operators:
            - "+" (1)
            - "-" (2)
            - "*" (3)
            - "/" (4);
        isBool := false;
        if op = 1 then fractionAdd(n1, d1, n2, d2, n, d)
        else if op = 2 then fractionSub(n1, d1, n2, d2, n, d)
        else if op = 3 then fractionMul(n1, d1, n2, d2, n, d)
        else if op = 4 then fractionDiv(n1, d1, n2, d2, n, d)
        else
        begin
            comment Handle boolean operators:
                - "<" (5)
                - ">" (6)
                - "==" (7)
                - "<=" (8)
                - ">=" (9)
                - "!=" (10);
            n := fractionComp(n1, d1, n2, d2);
            d := 1;
            isBool := true;
            boolResult := if op = 5 then n < 0
                else if op = 6 then n > 0
                else if op = 7 then n = 0
                else if op = 8 then  n <= 0
                else if op = 9 then n >= 0
                else n != 0
        end;
        comment If boolean operation, set numerator to 1 if true, 0 if false.
            Else reduce fraction;
        if isBool then n := if boolResult then 1 else 0
        else fractionReduce(n, d);

        fractionMath := isBool
    end fractionMath;

    procedure outFraction(n, d);
    value n, d;
    integer n, d;
    begin
        outIntegerNoSpace(n);
        outstring(1, "/");
        outIntegerNoSpace(d)
    end outFraction;

    integer procedure inAsciiChar;
    begin
        integer ch;

        comment For some reason '%' needs to be represented as '\x25'.
            Also, extra single quote needed to close backtick in string;
        inchar(
            0,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\"#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
            "PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f'",
            ch
        );
        if ch >= 129 then ch := 0;
        inAsciiChar := ch
    end inAsciiChar;

    integer procedure inCharArray(s, maxLen);
    value maxLen;
    integer array s;
    integer maxLen;
    begin
        integer len, ch;

        len := 0;
    inloop:
        ch := inAsciiChar;
        if ch != 0 & len < maxLen then
        begin
            len := len + 1;
            s[len] := ch;
            goto inloop
        end;

        inCharArray := len
    end inCharArray;

    integer argc, n1, d1, n2, d2, opLen, n, d;
    integer array opStr[1:3];
    boolean isBool;

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 3 then usage;

    comment Get fraction value from 1st argument. Exit if invalid;
    if !inFraction(n1, d1) then usage;

    comment Get operator from 2nd argument. Exit if empty;
    opLen := inCharArray(opStr, 3);
    if opLen < 1 then usage;

    comment Get fraction value from 3rd argument. Exit if invalid;
    if !inFraction(n2, d2) then usage;

    comment Perform fraction math;
    isBool := fractionMath(n1, d1, opStr, opLen, n2, d2, n, d);

    comment Display numerator if boolean operation, fraction otherwise;
    if isBool then outIntegerNoSpace(n)
    else outFraction(n, d);
    outstring(1, "\n")
end
