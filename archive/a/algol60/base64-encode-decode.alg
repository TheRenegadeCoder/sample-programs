begin
    procedure usage;
    begin
        outstring(1, "Usage: please provide a mode and a string to encode/decode\n");
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

    procedure outCharArray(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer i;
        for i := 1 step 1 until len do outAsciiChar(s[i])
    end outCharArray;

    comment Input mode. Return the following:
        - -1 if invalid mode
        - 0 if decode
        - 1 if encode;
    integer procedure inMode(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer mode;

        comment Assume invalid mode;
        mode := -1;

        comment Length must be 6 and the last 4 characters must be
            c (99) o (111) d (100) e(101);
        if len = 6 & s[3] = 99 & s[4] = 111 & s[5] = 100 & s[6] = 101 then
        begin
            comment Indicate encode if first 2 characters are e (101) and n (110).
                Indicate decode if first 2 characters are d (100) and e (101);
            if s[1] = 101 & s[2] = 110 then mode := 1
            else if s[1] = 100 & s[2] = 101 then mode := 0
        end;

        inMode := mode
    end inMode;

    comment Returns output length;
    integer procedure base64Encode(inStr, inLen, outStr);
    value inLen;
    integer array inStr, outStr;
    integer inLen;
    begin
        integer outLen, i, n1, n2, n3, u;

        outLen := 0;
        for i := 1 step 3 until inLen do
        begin
            comment Convert current 3 characters into 24-bit word, using zero
                if past end of string;
            n1 := inStr[i];
            n2 := if i + 1 <= inLen then inStr[i + 1] else 0;
            n3 := if i + 2 <= inLen then inStr[i + 2] else 0;
            u := 65536 * n1 + 256 * n2 + n3; comment (n1 << 16) | (n2 << 8) | n3;

            comment Convert 24-bit word to 4 character code and append to output
                string, using pad if past end of string;
            outStr[outLen + 1] := codeToBase64Char(inLen, u, 262144, i); comment u >> 18;
            outStr[outLen + 2] := codeToBase64Char(inLen, u, 4096, i); comment u >> 12;
            outStr[outLen + 3] := codeToBase64Char(inLen, u, 64, i + 1); comment u >> 6;
            outStr[outLen + 4] := codeToBase64Char(inLen, u, 1, i + 2);
            outLen := outLen + 4
        end;

        base64Encode := outLen
    end base64Encode;

    integer procedure mod(x, n);
    value x, n;
    integer x, n;
    begin
        mod := x - n * (x % n)
    end mod;

    integer procedure codeToBase64Char(len, u, d, sIdx);
    value len, u, d, sIdx;
    integer len, u, d, sIdx;
    begin
        integer idx, ch;

        comment Get 6-bit index from code;
        idx := mod(u % d, 64);

        comment
            If past end of string, use pad character, = (61)
            Else use the following:
                - 0  ... 25 -> A (65) ... Z (90)
                - 26 ... 51 -> a (97) ... z (122)
                - 52 ... 61 -> 0 (48) ... 9 (57)
                - 62        -> + (43)
                - 63        -> / (47);
        if sIdx > len then ch := 61
        else if idx >= 0 & idx <= 25 then ch := 65 + idx
        else if idx >= 26 & idx <= 51 then ch := 97 - 26 + idx
        else if idx >= 52 & idx <= 61 then ch := 48 - 52 + idx
        else if idx = 62 then ch := 43
        else ch := 47;

        codeToBase64Char := ch
    end codeToBase64Char;

    comment Returns output length if valid Base64 string, negative otherwise;
    integer procedure base64Decode(inStr, inLen, outStr);
    value inLen;
    integer array inStr, outStr;
    integer inLen;
    begin
        integer outLen, padLen, i, n1, n2, n3, n4, u;

        comment Assume invalid Base64 string;
        outLen := -1;

        comment Validate input length and number of trailing pad characters;
        padLen := countTrailingPads(inStr, inLen);
        if mod(inLen, 4) = 0 & padLen <= 2 then
        begin
            outLen := 0;
            i := 1;
            inLen := inLen - padLen;
        decloop:
            if i <= inLen - 1 & outLen >= 0 then
            begin
                comment Convert current 3 characters into 24-bit word, using zero
                    if past end of string. If any invalid characters, indicate
                    invalid input;
                n1 := base64CharToIndex(inStr[i]);
                n2 := base64CharToIndex(inStr[i + 1]);
                n3 := if i + 2 <= inLen then base64CharToIndex(inStr[i + 2]) else 0;
                n4 := if i + 3 <= inLen then base64CharToIndex(inStr[i + 3]) else 0;
                if n1 < 0 | n2 < 0 | n3 < 0 | n4 < 0 then outLen := -1
                else
                begin
                    comment (n1 << 18) | (n2 << 12) | (n3 << 6) | n4;
                    u := 262144 * n1 + 4096 * n2 + 64 * n3 + n4;

                    comment Convert 24-bit code to characters and append to output
                        string;
                    codeToOutStr(outStr, outLen, u, 65536, i, inLen); comment u >> 16;
                    codeToOutStr(outStr, outLen, u, 256, i + 2, inLen); comment u >> 8;
                    codeToOutStr(outStr, outLen, u, 1, i + 3, inLen)
                end;

                i := i + 4;
                goto decloop
            end
        end;

        base64Decode := outLen
    end base64Decode;

    comment Returns Base64 index if valid Base64 character, negative otherwise;
    integer procedure base64CharToIndex(ch);
    value ch;
    integer ch;
    begin
        integer idx;

        comment
            - A (65) ... Z (90)  -> 0  ... 25
            - a (97) ... z (122) -> 26 ... 51
            - 0 (48) ... 9 (57)  -> 52 ... 61
            - + (43)             -> 62
            - / (47)             -> 63
            - else               -> -1;
        if ch >= 65 & ch <=90 then idx := ch - 65
        else if ch >= 97 & ch <= 122 then idx := ch - 97 + 26
        else if ch >= 48 & ch <= 57 then idx := ch - 48 + 52
        else if ch = 43 then idx := 62
        else if ch =47 then idx := 63
        else idx := -1;

        base64CharToIndex := idx
    end base64CharToIndex;

    integer procedure countTrailingPads(s, len);
    value len;
    integer array s;
    integer len;
    begin
        integer padLen, i;

        comment Pad character is = (61);
        padLen := 0;
        i := len;
    padloop:
        if i >= 1 & s[i] = 61 then
        begin
            padLen := padLen + 1;
            i := i - 1;
            goto padloop
        end;

        countTrailingPads := padLen
    end countTrailingPads;

    procedure codeToOutStr(outStr, outLen, u, d, idx, inLen);
    value u, d, idx, inLen;
    integer array outStr;
    integer outLen, u, d, idx, inLen;
    begin
        if idx <= inLen then
        begin
            outLen := outLen + 1;
            outStr[outLen] := mod(u % d, 256)
        end
    end codeToOutStr;

    integer argc, inLen, outLen, mode;

    comment inStr is the input array, outStr is the output array.
        outStr must be big enough to hold the longest decode string
        (ceil[256 * 4 / 3] = 342);
    integer array inStr[1:256], outStr[1:342];

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 2 then usage;

    comment Get mode as a string as integer array. Exit if invalid;
    inLen := inCharArray(inStr, 256);
    mode := inMode(inStr, inLen);
    if mode < 0 then usage;

    comment Get string to encode or decode as integer array. Exit if empty;
    inLen := inCharArray(inStr, 256);
    if inLen < 1 then usage;

    comment If encode mode, Base64 encode string;
    if mode = 1 then outLen := base64Encode(inStr, inLen, outStr)
    else
    begin
        comment Exit if invalid Base64 string;
        outLen := base64Decode(inStr, inLen, outStr);
        if outLen < 0 then usage
    end;

    comment Output Base64 encode/decode string;
    outCharArray(outStr, outLen);
    outstring(1, "\n")
end
