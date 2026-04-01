begin
    procedure usage;
    begin
        outstring(1, "Usage: please provide a string\n");
        stop
    end usage;

    integer procedure inAsciiChar;
    begin
        integer ch;

        comment For some reason '%' needs to be represented as '\x25';
        inchar(
            0,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\"#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
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

    integer procedure longestWord(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer i, wordLen, maxWordLen, ch;

        wordLen := 0;
        maxWordLen := 0;
        for i := 1 step 1 until len do
        begin
            comment If whitespace, reset word length, else increment word length,
                and update maximum if necessary;
            ch := s[i];
            if ch = 9 | ch = 10 | ch = 13 | ch = 32 then wordLen := 0
            else begin
                wordLen := wordLen + 1;
                if wordLen > maxWordLen then maxWordLen := wordLen
            end
        end;

        longestWord := maxWordLen
    end longestWord;

    integer argc, len, maxWordLen;
    integer array s[1:256];

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get string as integer array. Exit if empty;
    len := inCharArray(s, 256);
    if len < 1 then usage;

    comment Get maximum word length and output it;
    maxWordLen := longestWord(s, len);
    outinteger(1, maxWordLen);
    outstring(1, "\n")
end
