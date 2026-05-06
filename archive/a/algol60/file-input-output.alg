begin
    integer ch;
    integer array buf[1:21];
    integer i, len;
    

    procedure writeFile;
    begin
        outstring(2, "Hello from ALGOL 60!");
    end;

    procedure outAsciiChar(ch);
    value ch;
    integer ch;
    begin
        outchar(
            1,
            "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
            "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
            " !\"#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
            "PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f'",
            ch
        )
    end;

    procedure printFile;
    begin
        integer i;
        for i := 1 step 1 until len do outAsciiChar(buf[i])
    end;

    procedure readFile;
    begin
        len := 0;

        for i := 1 step 1 until 20 do
        begin
            inchar(
                2,
                "\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f"
                "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
                " !\"#$\x25&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO"
                "PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f'",
                ch
            );
            comment map invalid chars to 0;
            if ch >= 129 then ch := 0;

            comment stop only on invalid;
            if ch = 0 then goto done;

            len := len + 1;
            buf[len] := ch;
        end;

    done:
    end;

    writeFile;
    readFile;
    printFile;

end