10 DIM A(99)
20 GOSUB 2000: REM Get array
30 IF V = 0 OR C <> -1 THEN GOTO 200: REM invalid or end of input/value
40 GOSUB 1000: REM Get target value
50 IF V = 0  OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
60 GOSUB 2500: REM Check if sorted
70 IF V = 0 THEN GOTO 200: REM not sorted
75 REM Perform binary search
80 T = NR
90 GOSUB 3000
100 R$ = "false"
110 IF I >= 0 THEN R$ = "true"
120 PRINT R$
130 END
200 Q$ = CHR$(34): REM quote
210 PRINT "Usage: please provide a list of sorted integers ";
220 PRINT "("; Q$; "1, 4, 5, 11, 12"; Q$; ") and the integer to find ";
230 PRINT "("; Q$; "11"; Q$; ")"
240 END
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
2500 REM Check if sorted
2502 REM - A contains array to search
2503 REM - NA contains size of array
2504 REM Outputs: V = 1 if sorted, 0 otherwise
2510 I = -1
2520 V = 1
2530 I = I + 1
2540 IF I >= (NA - 1) THEN RETURN
2550 IF A(I) > A(I + 1) THEN V = 0: RETURN: REM Not sorted
2560 GOTO 2530
3000 REM Binary search
3001 REM Inputs:
3002 REM - A contains array to search
3003 REM - NA contains size of array
3004 REM - T contains item to find
3005 REM Outputs: I contains index of array item found, -1 if not found
3010 I = -1
3020 LO = 0
3030 HI = NA - 1
3040 IF LO > HI THEN I = -1: RETURN: REM Not found
3050 MD = INT((LO + HI) / 2)
3060 IF A(MD) = T THEN I = MD: RETURN: REM Found
3070 IF A(MD) < T THEN LO = MD + 1: REM Too low, move lower bound
3080 IF A(MD) > T THEN HI = MD - 1: REM Too high, move upper bound
3090 GOTO 3040
