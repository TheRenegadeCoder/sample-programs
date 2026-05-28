begin
    comment ALGOL 60 really doesn't support file I/O, per se. It supports
        I/O via a channel number. With GNU MARST, an environment variable
        called FILE_<n> can be used to specify the file name for channel
        number n. Channel 3 is mapped to "output.txt".

        ALGOL 60 doesn't handle EOF (End-Of-File) gracefully. Instead it
        throws a fatal error and exits. To simulate an EOF, use the EOT
        (End-Of-Transmission) character (4);

    procedure outFile;
    begin
        comment A silly poem about ALGOL 60;
        outstring(3, "Travel back to ALGOL 60,\n");
        outstring(3, "Kind of simple, kind of nifty!\n");
        outstring(3, "But ponder with me for a while,\n");
        outstring(3, "Why it crashes on End-Of-File!\n");
        outstring(3, "\n");
        outstring(3, "A special symbol you will need,\n");
        outstring(3, "If you ever hope to succeed!\n");
        outstring(3, "What should we use, now let me see?\n");
        outstring(3, "Perhaps, per chance, an E-O-T!\n");
        outstring(3, "\x04")
    end outFile;

    integer procedure inFileAsciiChar;
    begin
        integer ch;

        comment For some reason '%' needs to be represented as '\x25'.
            Also, extra single quote needed to close backtick in string;
        inchar(
            3,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\"#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
            "PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f'",
            ch
        );
        if ch >= 129 then ch := 0;
        inFileAsciiChar := ch
    end inFileAsciiChar;

    comment Read file until newline, EOT, or buffer full.
        Return number of characters read;
    integer procedure inFileLine(buffer, bufsize);
    value bufsize;
    integer array buffer;
    integer bufsize;
    begin
        integer n, ch;
        n := 0;
    lineloop:
        ch := inFileAsciiChar;
        n := n + 1;
        buffer[n] := ch;
        if ch != 4 & ch != 13 & n < bufsize then goto lineloop;

        inFileLine := n
    end inFileLine;

    comment Read file a line at a time and output each line until EOT;
    integer procedure inFileAndOutput;
    begin
        integer array buffer[1:256];
        integer buflen;
    inloop:
        buflen := inFileLine(buffer, 256);
        outCharArray(buffer, buflen);
        if buffer[buflen] != 4 then goto inloop
    end inFile;

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

    procedure outCharArray(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer i;
        for i := 1 step 1 until len do outAsciiChar(s[i])
    end outCharArray;

    outFile;
    inFileAndOutput
end
