5 REM Input string
10 GOSUB 1000
20 IF S$ = "" THEN GOTO 80
30 R1$ = LEFT$(S$, 1)
40 IF R1$ >= "a" AND R1$ <= "z" THEN R1$ = CHR$(ASC(R1$) - 32)
50 R$ = R1$ + MID$(S$, 2)
60 PRINT R$
70 END
80 PRINT "Usage: please provide a string"
90 END
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
