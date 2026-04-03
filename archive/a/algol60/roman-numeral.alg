begin
    procedure usage;
    begin
        outstring(1, "Usage: please provide a string of roman numerals\n");
        stop
    end usage;

    procedure error;
    begin
        outstring(1, "Error: invalid string of roman numerals\n");
        stop;
    end error;

    integer procedure inAsciiChar;
    begin
        integer ch;

        comment
            To fix syntax highlighting on GitHub, use backslash x and:
            - 22 for double quote
            - 27 for single quote
            - 3b for semicolon
            For some reason percent sign needs to be represented as
            backslash x and 25;
        inchar(
            0,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\x22#$\x25&\x27()*+,-./0123456789:\x3b<=>?@ABCDEFGHIJKLMNO"
            "PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f",
            ch
        );
        if ch >= 128 then ch := 0;
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

    comment Convert Roman letter to value or 0 if invalid;
    integer procedure romanVal(ch);
    value ch;
    integer ch;
    begin
        integer val;

        comment
            I (73) -> 1
            V (86) -> 5
            X (88) -> 10
            L (76) -> 50
            C (67) -> 100
            D (68) -> 500
            M (77) -> 1000
            else -1;
        val := 0;
        if ch = 73 then val := 1
        else if ch = 86 then val := 5
        else if ch = 88 then val := 10
        else if ch = 76 then val := 50
        else if ch = 67 then val := 100
        else if ch = 68 then val := 500
        else if ch = 77 then val := 1000;

        romanVal := val
    end romanVal;

    comment Convert Roman numeral string to value or -1 if invalid;
    integer procedure romanNumeral(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer i, val, prevVal, total;

        total := 0;
        prevVal := -1;
        i := 1;
    romanloop:
        if i <= len & total >= 0 then
        begin
            comment Get value of current letter. If not found, indicate invalid and exit;
            val := romanVal(s[i]);
            if val < 1 then total := -1
            else
            begin
                comment Add value to total;
                total := total + val;

                comment If there is a previous value and value is greater than previous value,
                    subtract two times previous value from total to compensate for addition of
                    previous value -- e.g., if previous value was 100 (C) and current value is
                    1000 (M), the total currently equals 1100, but we want it to be 900
                    (1100 - 2*100). Also, reset the current value so that there is no previous
                    value;
                if prevVal > 0 & val > prevVal then
                begin
                    total := total - 2 * prevVal;
                    val := -1
                end;

                comment Store current value to previous value;
                prevVal := val;

                i := i + 1;
                goto romanloop
            end
        end;

        romanNumeral := total
    end romanNumeral;

    integer argc, len, result;
    integer array s[1:256];

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get string as integer array;
    len := inCharArray(s, 256);

    comment Convert Roman numeral string to value and output;
    result := romanNumeral(s, len);

    comment Output error if value is negative, else exit with error;
    if result < 0 then error;
    outinteger(1, result);
    outstring(1, "\n")
end
