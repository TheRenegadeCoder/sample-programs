MODULE Baklava;

FROM StrIO IMPORT WriteString, WriteLn;

PROCEDURE WriteRepeatString(s: ARRAY OF CHAR; n: CARDINAL);
VAR i: CARDINAL;
BEGIN
    FOR i := 1 TO n DO
        WriteString(s);
    END
END WriteRepeatString;

VAR
    n: INTEGER;
    numSpaces: CARDINAL;
    numStars: CARDINAL;

BEGIN
    FOR n := -10 TO 10 DO
        numSpaces := ABS(n);
        numStars := 21 - 2 * numSpaces;
        WriteRepeatString(' ', numSpaces);
        WriteRepeatString('*', numStars);
        WriteLn;
    END;
END Baklava.
