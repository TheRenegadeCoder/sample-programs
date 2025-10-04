5 REM Input fraction 1
10 GOSUB 2000
20 IF V = 0 OR C <> -1 THEN GOTO 200: REM invalid or end of input/value
30 N1 = N
40 D1 = D
45 REM Input operator
50 GOSUB 2500
60 IF S$ = "" THEN GOTO 200
70 OP$ = S$
75 REM Input fraction 2
80 GOSUB 2000
90 IF V = 0 OR C <> -1 THEN GOTO 200: REM invalid or end of input/value
100 N2 = N
110 D2 = D
115 REM Perform fraction math and display result
120 GOSUB 3000
130 IF V <> 0 THEN GOSUB 4000
140 END
200 PRINT "Usage: ./fraction-math operand1 operator operand2"
210 END
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
2000 REM Read fraction
2001 REM N contains numerator
2002 REM D contains denominator
2003 REM V = 1 if valid faction, 0 otherwise
2004 REM C = -2 if end of input, -1 if end of value,
2005 REM   32 if whitespace, ASCII code of last character otherwise
2010 GOSUB 1000: REM Read numerator value
2020 IF V = 0 THEN RETURN: REM invalid
2030 N = NR: REM store numerator
2040 D = 1: REM assume no denominator
2050 IF C < 0 THEN RETURN: REM end of input/value
2060 IF C <> 47 THEN GOTO 2110: REM not slash
2070 GOSUB 1000: REM Read denominator value
2080 IF V = 0 THEN RETURN: REM invalid
2090 D = NR: REM store denominator
2100 IF C < 0 THEN RETURN: REM end of input/value
2110 V = 0
2120 RETURN
2500 REM Read input value one character at a time since Commodore BASIC
2501 REM has trouble reading line from stdin properly
2502 REM S$ = string
2503 REM Initialize
2510 S$ = ""
2515 REM Append characters until end of input
2520 GET A$
2530 C = ASC(A$)
2540 IF C = 13 OR C = 255 THEN RETURN: REM end of value or input
2550 IF C = 9 OR C = 10 OR C = 32 THEN GOTO 2520: REM whitespace
2560 S$ = S$ + A$
2570 GOTO 2520
3000 REM Perform fraction math
3001 REM Inputs:
3002 REM - N1, D1 = Fraction 1
3003 REM - OP$ = Operator
3004 REM - N2, D2 = Fraction 2
3005 REM Outputs:
3006 REM - Boolean:
3007 REM   - B = 1
3008 REM   - NB = 1 if true, zero if false
3009 REM - Fraction:
3010 REM   - B = 0
3020 REM   - NR, DR = Fraction result
3030 REM - V = 1 if valid result, 0 otherwise
3040 V = 1: REM valid
3050 B = 0: REM not boolean
3060 IF OP$ = "+" THEN GOTO 3200
3070 IF OP$ = "-" THEN GOTO 3250
3080 IF OP$ = "*" THEN GOTO 3300
3090 IF OP$ = "/" THEN GOTO 3350
3100 B = 1: REM boolean
3110 GOSUB 3550: REM compare fractions
3120 IF OP$ = ">" THEN NB = (NB > 0): GOTO 3650
3130 IF OP$ = ">=" THEN NB = (NB >= 0): GOTO 3650
3140 IF OP$ = "<" THEN NB = (NB < 0): GOTO 3650
3150 IF OP$ = "<=" THEN NB = (NB <= 0): GOTO 3650
3160 IF OP$ = "==" THEN NB = (NB = 0): GOTO 3650
3170 IF OP$ = "!=" THEN NB = (NB <> 0): GOTO 3650
3180 PRINT "Invalid operator"
3190 V = 0: REM invalid
3195 RETURN
3200 REM Fraction addition
3201 REM N1/D1 + N2/D2 = (N1*D2 + N2*D1) / (D1*D2)
3210 NR = N1 * D2 + N2 * D1
3220 DR = D1 * D2
3230 GOTO 3400: REM reduce fraction
3250 REM Fraction subtraction
3251 REM N1/D1 - N2/D2 = (N1*D2 - N2*D1) / (D1*D2)
3260 NR = N1 * D2 - N2 * D1
3270 DR = D1 * D2
3280 GOTO 3400: REM reduce fraction
3300 REM Fraction multiplication
3301 REM N1/D1 * N2/D2 = (N1*N2) / (D1*D2)
3310 NR = N1 * N2
3320 DR = D1 * D2
3330 GOTO 3400: REM reduce fraction
3350 REM Fraction division
3351 REM (N1/D1) / (N2/D2) = (N1*D2) / (N2*D1)
3360 NR = N1 * D2
3370 DR = N2 * D1
3400 REM Reduce fraction
3401 REM Calculate GCD
3402 REM GA will contain GCD
3410 GA = ABS(NR)
3420 GB = ABS(DR)
3430 IF GB = 0 THEN GOTO 3480
3440 T = GB
3450 GB = GA - INT(GA / GB) * GB: REM GA mod GB
3460 GA = T
3470 GOTO 3430
3480 REM Fix up signs
3481 REM N  D  sign N  sign D
3482 REM +  +     +       +
3483 REM +  -     -       +
3484 REM -  +     -       +
3485 REM -  -     +       +
3500 NR = SGN(DR) * NR / GA
3510 DR = ABS(DR) / GA
3520 RETURN
3550 REM Compare fractions
3551 REM Inputs:
3552 REM - N1, D1 = Fraction 1
3553 REM - N2, D2 = Fraction 2
3554 REM Output: NB = result of compare:
3555 REM - positive if N1/D1 > N2/D2
3556 REM - zero if N1/D1 == N2/D2
3557 REM - negative if N1/D1 < N2/D2
3560 NB = N1 * D2 - N2 * D1
3600 RETURN
3650 REM Convert comparison to 1 if true, 0 otherwise
3660 IF NB <> 0 THEN NB = 1
3670 RETURN
4000 REM Display fraction math result
4001 REM Inputs:
4002 REM   - B = 1
4003 REM   - NB = 1 if true, 0 if false
4004 REM - Fraction:
4005 REM   - B = 0
4006 REM   - NR, DR = Fraction result
4010 IF B <> 0 THEN GOTO 4080
4020 SN$ = STR$(NR)
4030 IF NR >= 0 THEN SN$ = MID$(SN$, 2): REM remove leading space
4040 SD$ = STR$(DR)
4050 IF DR >= 0 THEN SD$ = MID$(SD$, 2): REM remove leading space
4060 S$ = SN$ + "/" + SD$
4070 GOTO 4090
4080 S$ = MID$(STR$(NB), 2)
4090 PRINT S$
4100 RETURN
