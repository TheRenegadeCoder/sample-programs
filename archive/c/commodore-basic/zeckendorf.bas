5 REM Input N
10 GOSUB 1000
20 IF V = 0 OR C >=0 OR NR < 0 THEN GOTO 110: REM invalid or not end character
30 N = NR
35 REM Max Fibonacci numbers than can be displayed as integers
40 MF = 43
50 DIM F(MF - 1)
55 REM Max Zeckendorf values
60 MZ = INT((MF + 1) / 2)
70 DIM A(MZ - 1)
75 REM Get Zeckendorf values
80 GOSUB 2000
85 REM Display results
90 GOSUB 3500
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
2000 REM Get Zeckendorf values
2001 REM N = input number
2002 REM A = array containing Fibonacci numbers that add up to N
2003 REM NA = size of array
2005 REM Get Fibonacci numbers up to an including N
2010 GOSUB 3000
2015 REM Get Fibonacci numbers that add up to N
2020 K = NF - 1
2030 NA = 0
2040 IF K < 0 OR N < 1 THEN GOTO 2130
2045 REM Get Fibonacci value
2050 FV = F(K)
2060 K = K - 1
2065 REM If Too large, get previous Fibonacci value
2070 IF FV > N THEN GOTO 2040
2075 REM Store Fibonacci value and skip previous one
2080 A(NA) = FV
2090 NA = NA + 1
2100 K = K - 1
2110 N = N - FV
2120 GOTO 2040
2130 RETURN
3000 REM Fibonacci numbers up to an including N
3001 REM N = input number
3002 REM F = array of Fibonacci
3003 REM NF = number of Fibonacci numbers
3010 FA = 1
3020 FB = 2
3030 NF = 0
3040 IF FA > N OR NF >= MF THEN GOTO 3110
3050 F(NF) = FA
3060 NF = NF + 1
3070 FC = FA + FB
3080 FA = FB
3090 FB = FC
3100 GOTO 3040
3110 RETURN
3500 REM Display array
3501 REM A contains array
3502 REM NA contains size of array
3510 IF NA < 1 THEN GOTO 3590
3520 FOR I = 0 TO NA - 1
3530    S$ = STR$(A(I))
3540    IF A(I) >= 0 THEN S$ = MID$(S$, 2): REM strip leading space
3550    PRINT S$;
3560    IF I < (NA - 1) THEN PRINT ", ";
3570 NEXT I
3580 PRINT
3590 RETURN
