begin
    procedure usage;
    begin
        outstring(1, "Usage: please input a number\n");
        stop
    end usage;

    comment Input a digit character from stdin and return the following:
        - "0" to "9" maps to 0 to 9
        - "+" maps to 10
        - "-" maps to 11
        - whitespace maps to 12
        - comma maps to 13
        - null byte maps to -1
        - invalid bytes map to -2;
    integer procedure indigit;
    begin
        comment Mapping:
            - "0" to "9" maps to 1 to 10
            - "+" maps to 11
            - "-" maps to 12
            - "," mapps to 13
            - "\t" maps to 14
            - "\r" maps to 15
            - "\n" maps to 16
            - " " maps to 17
            - null byte maps to 18
            - invalid byte maps 0;
        integer ch;
        inchar(0, "0123456789+-,\t\r\n ", ch);
        if ch < 1 then ch := -2
        else if ch < 14 then ch := ch - 1
        else if ch < 18 then ch := 12
        else ch := -1;
        indigit := ch
    end indigit;

    comment Input an integer from stdin into 'result' and parse it.
        return true if integer is valid, false otherwise;
    boolean procedure inValidInteger(result);
    integer result;
    begin
        integer chValue;
        boolean valid;

        result := 0;
        valid := true;

    loop1:
        chValue := indigit;
        outinteger(1, chValue);
        if chValue < 0 then goto done;

        outstring(1, " ");
        goto loop1;

    done:
        outstring(1, "\n");
        inValidInteger := valid
    end inValidInteger;

    integer argc, result;

    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 1 then usage;

    comment Get integer value from 1st argument. Exit if too few;
    if !inValidInteger(result) then usage;

    outinteger(1, result);
    outstring(1, "\n")
end
