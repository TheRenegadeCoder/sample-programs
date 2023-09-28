5 REM Read input string
10 GOSUB 1000
20 IF S$ = "" AND C = 255 THEN GOTO 240: REM no input
30 V = 0
40 PD = 0
50 K = 1
60 IF K > LEN(S$) THEN GOTO 220
70 L$ = MID$(S$, K, 1)
80 K = K + 1
90 D = 0
100 IF L$ = "M" THEN D = 1000
110 IF L$ = "D" THEN D = 500
120 IF L$ = "C" THEN D = 100
130 IF L$ = "L" THEN D = 50
140 IF L$ = "X" THEN D = 10
150 IF L$ = "V" THEN D = 5
160 IF L$ = "I" THEN D = 1
170 IF D = 0 THEN GOTO 260: REM Invalid letter
180 V = V + D
185 REM Subtract if the previous digit valid and smaller
190 IF PD > 0 AND PD < D THEN V = V - 2 * PD: D = 0
200 PD = D
210 GOTO 60
220 PRINT MID$(STR$(V), 2)
230 END
240 PRINT "Usage: please provide a string of roman numerals"
250 END
260 PRINT "Error: invalid string of roman numerals"
270 END
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
