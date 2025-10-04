FOR n FROM -10 TO 10
DO
    INT num spaces := ABS n;
    printf(($gl$, " " * num spaces + "*" * (21 - 2*num spaces)))
OD
