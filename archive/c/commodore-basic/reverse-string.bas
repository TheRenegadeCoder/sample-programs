5 REM Input string
10 GOSUB 1000
20 R$ = ""
30 IF S$ = "" THEN GOTO 70
40 FOR K = LEN(S$) TO 1 STEP -1
50     R$ = R$ + MID$(S$, K, 1)
60 NEXT K
70 PRINT R$
80 END
1000 REM Read input value one character at a time since Commodore BASIC
1001 REM has trouble reading line from stdin properly
1002 REM S$ = string
1003 REM Initialize
1010 S$ = ""
1015 REM Append characters until end of value or input
1020 GET A$
1030 C = ASC(A$)
1040 IF C = 13 OR C = 255 THEN RETURN: REM end of value or input
1050 S$ = S$ + A$
1060 GOTO 1020
