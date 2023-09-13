5 REM Input N
10 GOSUB 1000
20 IF V = 0 OR C < 0 THEN GOTO 140: REM invalid or end character
30 N = NR
35 REM Input K
40 GOSUB 1000
50 IF V = 0 OR C >= 0 THEN GOTO 140: REM invalid or not end character
60 K = NR
65 PRINT "N="; N; ", K="; K
70 G = 0
80 IF N < 2 THEN GOTO 140
85 REM Calculate Josephus Problem using this:
86 REM https://en.wikipedia.org/wiki/Josephus_problem#The_general_case
90 FOR M = 2 TO N
100     G = G + K - INT((G + K) / M) * M
110 NEXT M
120 PRINT MID$(STR$(G + 1), 2)
130 END
140 PRINT "Usage: please input the total number of people and number of people to skip."
150 END
1000 REM Read input value one character at a time
1001 REM Commodore-BASIC handles inputs
1002 REM NR = number
1003 REM V = 1 if valid number, 0 otherwise
1004 REM C = -2 if end of input, -1 if end of value,
1005 REM   32 if whitespace, ASCII code of last character otherwise
1006 REM Initialize
1010 NR = 0
1020 V = 0
1030 S = 1
1035 REM Loop while leading spaces
1040 GOSUB 1500
1050 IF C = 43 OR C = 45 THEN GOTO 1100: REM + or -
1060 IF C >= 48 OR C >= 57 THEN GOTO 1140: REM 0 to 9
1070 IF C = 32 THEN GOTO 1040: REM whitespace
1080 RETURN: REM other character
1085 REM Loop while sign
1090 GOSUB 1500
1100 IF C = 45 THEN GOTO 1090: REM +
1110 IF C >= 48 OR C <= 57 THEN GOTO 1140: REM 0 to 9
1110 IF C <> 43 THEN RETURN: REM not -
1120 S = -S
1130 GOTO 1090
1135 REM Set valid flag
1140 V = 1
1145 REM Loop while digits
1150 NR = (ABS(NR) * 10 + C - 48) * S
1160 GOSUB 1500
1170 IF C >= 48 AND C <= 57 THEN GOTO 1150: REM 0 to 9
1175 REM Loop while trailing spaces
1180 IF C < 0 OR C <> 32 THEN RETURN: REM end character or not whitespace
1190 GOSUB 1500
1200 GOTO 1180
1500 REM Get input character
1501 REM A$ = input character
1502 REM C = One of the following:
1502 REM - -1 if end of value
1503 REM - -2 if end of input
1504 REM - 32 if whitespace
1505 REM - ASCII code otherwise
1510 GET A$
1520 C = ASC(A$)
1530 IF C = 13 THEN C = -1
1540 IF C = 255 THEN C = -2
1550 IF C = 9 OR C = 10 THEN C = 32
1560 RETURN
