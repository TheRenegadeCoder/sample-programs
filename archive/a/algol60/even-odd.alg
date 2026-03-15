begin
    procedure usage;
    begin
        outstring(1, "Usage: please input a number\n");
        stop
    end usage;

    comment Input an integer from stdin into 'result' and parse it.
        return true if integer is valid, false otherwise;
    boolean procedure inValidInteger(result);
    integer result;
    begin
        integer chValue;
        boolean valid;

        result := 0;
        valid := true;

    comment "0" to "9" maps to 1 to 10, "+" maps to 11, "-" maps to 12,
        space maps to 13, null maps to 14, invalid character maps to 0;
    loop1:
        inchar(0, "0123456789+- ", chValue);
        outinteger(1, chValue);
        if chValue < 1 | chValue > 13 then
            goto done;

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
