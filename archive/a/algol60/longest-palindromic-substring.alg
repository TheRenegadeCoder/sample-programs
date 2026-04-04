begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide a string that contains at least one palindrome\n"
        );
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

    procedure outCharSubArray(s, left, right);
    value left, right;
    integer array s;
    integer left, right;
    begin
        integer i;
        for i := left step 1 until right do outAsciiChar(s[i])
    end outCharSubArray;

    comment Reference:
        https://coderraj07.medium.com/expand-around-center-the-secret-weapon-for-palindrome-problems-b8e40171e538;
    integer procedure longestPalindromicSubstring(s, len, left, right);
    value len;
    integer len, left, right;
    integer array s;
    begin
        integer procedure expandAroundCenter(l, r);
        integer l, r;
        begin
            comment Update left and right until out-of-bounds or non-matching
                characters;
        expandloop:
            if l >= 1 & r <= len then
            begin
                if s[l] = s[r] then
                begin
                    l := l - 1;
                    r := r + 1;
                    goto expandloop
                end
            end;

            comment Undo last left and right update;
            l := l + 1;
            r := r - 1;
            expandAroundCenter := r - l + 1
        end expandAroundCenter;

        integer i, j, tempLeft, tempRight, tempLen, bestLen;

        comment Initialize left and right to start;
        left := 1;
        right := 1;
        bestLen := 1;

        comment For each starting position (i);
        for i := 1 step 1 until len do
        begin
            for j := 0 step 1 until 1 do
            begin
                comment Find longest palindromic substring for odd (j = 0) or
                    even (j = 1) length starting at position i;
                tempLeft := i;
                tempRight := i + j;
                tempLen := expandAroundCenter(tempLeft, tempRight);

                comment Update left and right if longer palindromic substring found;
                if tempLen > bestLen then
                begin
                    left := tempLeft;
                    right := tempRight;
                    bestLen := tempLen
                end
            end
        end;

        longestPalindromicSubstring := right - left + 1
    end longestPalindromicSubstring;

    integer argc, len, left, right, subLen;
    integer array s[1:256];

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get string as integer array. Exit if empty;
    len := inCharArray(s, 256);
    if len < 1 then usage;

    comment Find longest palindromic substring. Exit if length less than 2;
    subLen := longestPalindromicSubstring(s, len, left, right);
    if subLen < 2 then usage;

    comment Output longest palindromic substring;
    outCharSubArray(s, left, right);
    outstring(1, "\n")
end
