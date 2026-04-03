begin
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

    procedure reverseString(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer left, right, temp;

        left := 1;
        right := len;
    revloop:
        if left < right then
        begin
            temp := s[left];
            s[left] := s[right];
            s[right] := temp;
            left := left + 1;
            right := right - 1;
            goto revloop
        end
    end reverseString;

    integer argc, len;
    integer array s[1:256];

    comment Get number of parameters;
    ininteger(0, argc);

    comment If any parameters,;
    if argc > 0 then
    begin
        comment Get string as integer array;
        len := inCharArray(s, 256);

        comment Reverse string and output string as integer array;
        reverseString(s, len);
        outCharArray(s, len);
        if len > 0 then outstring(1, "\n")
    end
end
