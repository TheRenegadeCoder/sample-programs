begin
    procedure usage;
    begin
        outstring(1, "Usage: please provide a string\n");
        stop
    end usage;

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

    procedure outAsciiChar(ch);
    value ch;
    integer ch;
    begin
        comment For some reason '%' needs to be represented as '\x25'.
            Also, extra single quote needed to close backtick in string;
        outchar(
            1,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\"#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
            "PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f'",
            ch
        )
    end outAsciiChar;

    integer procedure duplicateCharacterCounter(s, len, charCounts, foundChars);
    value len;
    integer array s, charCounts, foundChars;
    integer len;
    begin
        integer i, ch, numFoundChars;

        comment Initialize character counts;
        for i := 1 step 1 until 127 do charCounts[i] := 0;

        comment Count number of times each character is found and keep
            track of each unique character found;
        numFoundChars := 0;
        for i := 1 step 1 until len do
        begin
            ch := s[i];
            charCounts[ch] := charCounts[ch] + 1;
            if charCounts[ch] = 1 then
            begin
                numFoundChars := numFoundChars + 1;
                foundChars[numFoundChars] := ch
            end
        end;

        duplicateCharacterCounter := numFoundChars
    end duplicateCharacterCounter;

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
            outchar(1, "0123456789", x + 1)
        end digits;
        if x < 0 then outstring(1, "-");
        digits(abs(x))
    end outIntegerNoSpace;

    procedure outDuplicateCharacterCounts(charCounts, foundChars, numFoundChars);
    value numFoundChars;
    integer numFoundChars;
    integer array charCounts, foundChars;
    begin
        boolean dupesFound;
        integer i, ch;

        dupesFound := false;
        for i := 1 step 1 until numFoundChars do
        begin
            ch := foundChars[i];
            if charCounts[ch] > 1 then
            begin
                dupesFound := true;
                outAsciiChar(ch);
                outstring(1, ": ");
                outIntegerNoSpace(charCounts[ch]);
                outstring(1, "\n")
            end
        end;

        if !dupesFound then outstring(1, "No duplicate characters\n")
    end outDuplicateCharacterCounts;

    integer argc, len, numFoundChars;
    integer array s[1:256], charCounts[1:127], foundChars[1:127];

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get string as integer array. Exit if empty;
    len := inCharArray(s, 256);
    if len < 1 then usage;

    comment Get duplicate character counts and show duplicate character counts;
    numFoundChars := duplicateCharacterCounter(s, len, charCounts, foundChars);
    outDuplicateCharacterCounts(charCounts, foundChars, numFoundChars)
end
