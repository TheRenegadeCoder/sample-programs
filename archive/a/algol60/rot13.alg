begin
    procedure usage;
    begin
        outstring(1, "Usage: please provide a string to encrypt\n");
        stop
    end usage;

    integer procedure inAsciiChar;
    begin
        integer ch;

        comment
            The fix syntax highlighting on GitHub, use '\x22' for '"'.
            For some reason '%' needs to be represented as '\x25';
        inchar(
            0,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\x22#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
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

    procedure outAsciiChar(ch);
    value ch;
    integer ch;
    begin
        comment
            The fix syntax highlighting on GitHub, use '\x22' for '"'.
            For some reason '%' needs to be represented as '\x25';
        outchar(
            1,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\x22#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
            "PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f",
            ch
        )
    end outAsciiChar;

    procedure outCharArray(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer i;
        for i := 1 step 1 until len do outAsciiChar(s[i])
    end outCharArray;

    procedure rot13(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer i, ch;

        for i := 1 step 1 until len do
        begin
            comment
                A (65)  ... M (77)  -> N (78)  ... Z (90)
                a (97)  ... m (109) -> n (110) ... z (122)
                N (78)  ... Z (90)  -> A (65)  ... M (77)
                n (110) ... z (122) -> a (97)  ... m (109);
            ch := s[i];
            if (ch >= 65 & ch <= 77) | (ch >= 97 & ch <= 109) then
                s[i] := s[i] + 13
            else if (ch >= 78 & ch <= 90) | (ch >= 110 & ch <= 122) then
                s[i] := s[i] - 13
        end
    end capitialize;

    integer argc, len;
    integer array s[1:256];

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get string as integer array. Exit if empty;
    len := inCharArray(s, 256);
    if len < 1 then usage;

    comment Encrypt string with Rot13 and output string as integer array;
    rot13(s, len);
    outCharArray(s, len);
    outstring(1, "\n")
end
