PROC write file = (STRING file name) INT:
(
    FILE f;
    INT status := establish(f, file name, stand out channel);
    IF status /= 0
    THEN
        put(stand error, ("Cannot open ", file name, " for write", new line))
    ELSE
        put(f, ("Hello from Algol 68!", new line));
        put(f, ("Here is a line", new line));
        put(f, ("Here is another line", new line));
        put(f, ("Goodbye!", new line));
        close(f)
    FI;

    status
);

PROC read file = (STRING file name) INT:
(
    FILE f;
    INT status := open(f, file name, stand in channel);
    IF status /= 0
    THEN
        put(stand error, ("Cannot open ", file name, " for read", new line))
    ELSE
        on logical file end(f, (REF FILE inf) BOOL:
            (
                close(inf);
                done
            )
        );

        STRING line;
        DO
            get(f, (line, new line));
            write((line, new line))
        OD
    FI;

done:
    status
);

STRING file name := "output.txt";
IF write file(filename) /= 0
THEN
    stop
FI;

IF read file(filename) /= 0
THEN
    stop
FI
