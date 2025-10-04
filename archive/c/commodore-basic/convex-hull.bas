10 DIM A(99), P(99, 1), H(99, 1)
15 REM Get x values
20 GOSUB 2000
30 IF V = 0 OR C <> -1 THEN GOTO 200: REM invalid or not end of value
40 NP = NA
50 FOR I = 0 TO NA - 1
60     P(I, 0) = A(I)
70 NEXT I
75 REM Get y values
80 GOSUB 2000
90 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end input/value
100 FOR I = 0 TO NA - 1
110    P(I, 1) = A(I)
120 NEXT I
125 REM Validate number of x and y values
130 IF NP <> NA OR NP < 3 THEN GOTO 200
135 REM Perform convex hull and show results
140 GOSUB 3000
150 GOSUB 3500
160 END
200 Q$ = CHR$(34): REM quote
210 PRINT "Usage: please provide at least 3 x and y coordinates as separate ";
220 PRINT "lists (e.g. "; Q$; "100, 440, 210"; Q$; ")"
230 END
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
2000 REM Read array value
2001 REM A contains array value
2002 REM NA contains length of array
2003 REM V = 1 if valid number, 0 otherwise
2004 REM C = -2 if end of input, -1 if end of value,
2005 REM   32 if whitespace, ASCII code of last character otherwise
2006 REM Initialize
2010 NA = 0
2020 GOSUB 1000: REM Read input value
2030 IF V = 0 THEN RETURN: REM invalid
2040 A(NA) = NR
2050 NA = NA + 1
2060 IF C < 0 THEN RETURN: REM end of input or value
2070 IF C = 44 THEN GOTO 2020: REM comma, get next value
2080 V = 0
2090 RETURN
3000 REM Find Convex Hull using Jarvis' algorithm
3001 REM Source:
3002 REM https://www.geeksforgeeks.org/
3003 REM convex-hull-using-jarvis-algorithm-or-wrapping/
3004 REM Inputs:
3005 REM - P contains points
3006 REM - NP contains number of points
3007 REM Outputs:
3008 REM - H contains hull points
3009 REM - NH contains number of hull points
3010 REM Initialize hull points
3020 NH = 0
3030 REM The first point is the leftmost point with the highest y-coord in the
3040 REM event of a tie
3050 LI = 0
3070 FOR I = 1 TO NP - 1
3080     IF P(I, 0) < P(LI, 0) THEN GOTO 3100
3090     IF P(I, 0) <> P(LI, 0) OR P(I, 1) <= P(LI, 1) THEN GOTO 3110
3100     LI = I
3110 NEXT I
3120 PI = LI
3125 REM Store hull point
3130 H(NH, 0) = P(PI, 0)
3140 H(NH, 1) = P(PI, 1)
3150 NH = NH + 1
3155 REM Update end point if point found is more counter-clockwise
3160 QI = PI + 1
3170 IF QI >= NP THEN QI = QI - NP
3180 FOR J = 0 TO NP -1
3181     REM Determine orientation:
3182     REM - 0 means points in a line
3183     REM - > 0 means points are clockwise
3184     REM - < 0 mean points are counter-clockwise
3190     O = (P(J, 1) - P(PI, 1)) * (P(QI, 0) - P(J, 0))
3200     O = O - (P(J, 0) - P(PI, 0)) * (P(QI, 1) - P(J, 1))
3210     IF O < 0 THEN QI = J
3220 NEXT J
3225 REM Repeat until wrapped to first hull point
3230 PI = QI
3240 IF PI <> LI THEN GOTO 3130
3250 RETURN
3500 REM Display hull points
3501 REM Inputs:
3502 REM - H contains hull points
3503 REM - NH contains number of hull points
3510 IF NA < 1 THEN GOTO 3590
3520 FOR I = 0 TO NH - 1
3530    SX$ = STR$(H(I, 0))
3540    IF H(I, 0) >= 0 THEN SX$ = MID$(SX$, 2): REM strip leading space
3550    SY$ = STR$(H(I, 1))
3560    IF H(I, 1) >= 0 THEN SY$ = MID$(SY$, 2): REM strip leading space
3570    PRINT "("; SX$; ", "; SY$; ")"
3580 NEXT I
3590 RETURN
