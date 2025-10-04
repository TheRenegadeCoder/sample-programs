PROC reverse string = (STRING s) STRING:
(
    STRING t;
    FOR n FROM UPB s DOWNTO 1
    DO
        t +:= s[n]
    OD;

    t
);

# Get 1st command-line argument #
STRING s := argv(4);

# Reverse string and show result #
s := reverse string(s);
printf(($gl$, s))
