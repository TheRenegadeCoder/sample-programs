5 REM Input N
10 GOSUB 1000
20 IF V = 0 OR C >=0 OR NR < 0 THEN GOTO 110: REM invalid or not end character
30 N = NR
40 F = 1
50 IF N < 2 THEN GOTO 90
60 FOR K = 2 TO N
70     F = F * K
80 NEXT K
90 PRINT MID$(STR$(F), 2)
100 END
110 PRINT "Usage: please input a non-negative integer"
120 END
1000 REM Read input value one character at a time since Commodore BASIC
1001 REM has trouble reading line from stdin properly
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
1060 IF C >= 48 AND C <= 57 THEN GOTO 1150: REM 0 to 9
1070 IF C = 32 THEN GOTO 1040: REM whitespace
1080 RETURN: REM other character
1085 REM Loop while sign
1090 GOSUB 1500
1100 IF C = 43 THEN GOTO 1090: REM +
1110 IF C >= 48 AND C <= 57 THEN GOTO 1150: REM 0 to 9
1120 IF C <> 45 THEN RETURN: REM not -
1130 S = -S
1140 GOTO 1090
1145 REM Set valid flag
1150 V = 1
1155 REM Loop while digits
1160 NR = (ABS(NR) * 10 + C - 48) * S
1170 GOSUB 1500
1180 IF C >= 48 AND C <= 57 THEN GOTO 1160: REM 0 to 9
1185 REM Loop while trailing spaces
1190 IF C < 0 OR C <> 32 THEN RETURN: REM end character or not whitespace
1200 GOSUB 1500
1210 GOTO 1180
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
