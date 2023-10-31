10 DIM A(99)
20 DIM M(9, 9): REM Allow up to a 10x10 matrix
30 DIM T(9, 9): REM Storage for matrix transpose
15 REM Get number of columns
20 GOSUB 1000
30 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
40 MC = NR
45 REM Get number of rows
50 GOSUB 1000
60 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
70 MR = NR
75 REM Get matrix as an array
80 GOSUB 2000
90 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
100 IF NA <> (MC * MR) THEN GOTO 200: REM incorrect matrix size
105 REM Convert array to matrix
110 GOSUB 2500
115 REM Get matrix transpose
120 GOSUB 3000
125 REM Convert matrix transpose back to array and display
130 GOSUB 3500
140 GOSUB 4000
150 END
200 PRINT "Usage: please enter the dimension of the matrix ";
210 PRINT "and the serialized matrix"
220 END
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
2500 REM Convert array to matrix
2501 REM Inputs:
2502 REM - A contains array
2503 REM - MR contains number of rows
2504 REM - MC contains number of columns
2505 REM Output: M contains matrix
2510 N = -1
2520 FOR I = 0 TO MR - 1
2530     FOR J = 0 TO MC - 1
2540         N = N + 1
2550         M(I, J) = A(N)
2560     NEXT J
2570 NEXT I
2580 RETURN
3000 REM Calculate matrix transpose
3001 REM Inputs:
3002 REM - M contains matrix
3003 REM - MR contains number of rows
3004 REM - MC contains number of columns
3005 REM Outputs:
3006 REM - T contains matrix transpose
3007 REM - TR contains number of rows in matrix transpose
3008 REM - TC contains number of columns in matrix transpose
3010 FOR I = 0 TO MR - 1
3020     FOR J = 0 TO MC - 1
3030         T(J, I) = M(I, J)
3040     NEXT J
3050 NEXT I
3060 TR = MC
3070 TC = MR
3080 RETURN
3500 REM Convert matrix transpose to array
3501 REM Inputs:
3502 REM - T contains matrix transpose
3503 REM - TR contains number of rows in matrix transpose
3504 REM - TC contains number of columns in matrix transpose
3505 REM Outputs:
3506 REM - A contains array
3507 REM - NA contains size of array
3508 NA = 0
3510 FOR I = 0 TO TR - 1
3520     FOR J = 0 TO TC - 1
3530         A(NA) = T(I, J)
3540         NA = NA + 1
3550     NEXT J
3560 NEXT I
3570 RETURN
4000 REM Display array
4001 REM A contains array
4002 REM NA contains size of array
4010 IF NA < 1 THEN GOTO 3590
4020 FOR I = 0 TO NA - 1
4030    S$ = STR$(A(I))
4040    IF A(I) >= 0 THEN S$ = MID$(S$, 2): REM strip leading space
4050    PRINT S$;
4060    IF I < (NA - 1)THEN PRINT ", ";
4070 NEXT I
4080 PRINT
4090 RETURN
