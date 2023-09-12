5 REM Input N
10 GOSUB 1000
20 IF V = 0  OR C = 255 THEN GOTO 140
30 N = NR
35 REM Input K
40 GOSUB 1000
50 IF V = 0 THEN GOTO 140
60 K = NR
70 G = 0
80 IF N < 2 THEN GOTO 140
85 REM Calculate Josephus Problem using this:
86 REM https://en.wikipedia.org/wiki/Josephus_problem#The_general_case
90 FOR M = 2 TO N
100 G = G + K - INT((G + K) / M) * M
110 NEXT M
120 PRINT MID$(STR$(G + 1), 2)
130 END
140 PRINT "Usage: please input the total number of people and number of people to skip."
150 END
1000 REM Read input value
1001 REM NR = number
1002 REM V = 1 if valid number, 0 otherwise
1003 REM C = 255 if end of input, 13 if end of value,
1004 REM   ASCII code of last character otherwise
1005 REM Initialize
1010 NR = 0
1020 V = 0
1025 REM Loop while leading spaces
1030 GET A$
1040 C = ASC(A$)
1050 IF C = 255 THEN RETURN
1060 IF C = 32 THEN GOTO 1030
1065 REM Loop while digits
1070 IF C < 48 OR C > 57 THEN RETURN
1080 V = 1
1090 NR = NR * 10 + C - 48
1100 GET A$
1110 C = ASC(A$)
1120 IF C >= 48 AND C <= 57 THEN GOTO 1090
1130 IF C = 255 OR C = 13 THEN RETURN
1025 REM Loop while trailing spaces
1140 IF C <> 32 THEN GOTO 1190
1150 GET A$
1160 C = ASC(A$)
1170 IF C = 13 OR C = 255 THEN RETURN
1180 GOTO 1140
1190 V = 0
1200 RETURN
