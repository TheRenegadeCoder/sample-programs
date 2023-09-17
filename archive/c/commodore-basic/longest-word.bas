5 REM Input string
10 GOSUB 1000
20 IF S$ = "" OR S$ = CHR$(13) THEN GOTO 160
25 REM Keep track of length of longest word
30 LW% = 0: REM longest word length so far
40 LC% = 0: REM current word length
50 FOR K = 1 TO LEN(S$)
60     A$ = MID$(S$, K, 1)
70     IF A$ = CHR$(9) OR A$ = CHR$(10) OR A$ = CHR$(13) THEN GOTO 120
80     IF A$ = " " THEN GOTO 120: REM can't put on same line, too long
90     LC% = LC% + 1
100     IF LC% > LW% THEN LW% = LC%
110     GOTO 130
120     LC% = 0
130 NEXT K
140 PRINT MID$(STR$(LW%), 2)
150 END
160 PRINT "Usage: please provide a string"
170 END
1000 REM Read input value one character at a time since Commodore BASIC
1001 REM has trouble reading line from stdin properly
1002 REM S$ = string
1003 REM Initialize
1010 S$ = ""
1015 REM Append characters until end of input
1020 GET A$
1030 C = ASC(A$)
1040 IF C = 255 THEN RETURN: REM end of input
1050 S$ = S$ + A$
1060 GOTO 1020
