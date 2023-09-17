5 REM Input string
10 GOSUB 1000
20 IF S$ = "" THEN GOTO 130
30 R$ = ""
40 FOR K = 1 TO LEN(S$)
50     A$ = MID$(S$, K, 1)
60     M% = 0
65     REM Offset by 13 if A-M or a-m, 13 if N-Z or n-z, 0 otherwise
70     IF (A$ >= "A" AND A$ <= "M") OR (A$ >= "a" AND A$ <= "m") THEN M% = 13
80     IF (A$ >= "N" AND A$ <= "Z") OR (A$ >= "n" AND A$ <= "z") THEN M% = -13
90     R$ = R$ + CHR$(ASC(A$) + M%)
100 NEXT K
110 PRINT R$
120 END
130 PRINT "Usage: please provide a string to encrypt"
140 END
1000 REM Read input value one character at a time since Commodore BASIC
1001 REM has trouble reading line from stdin properly
1002 REM S$ = string
1003 REM Initialize
1010 S$ = ""
1015 REM Append characters until end of input
1020 GET A$
1030 C = ASC(A$)
1040 IF C = 13 OR C = 255 THEN RETURN: REM end of value or input
1050 S$ = S$ + A$
1060 GOTO 1020
