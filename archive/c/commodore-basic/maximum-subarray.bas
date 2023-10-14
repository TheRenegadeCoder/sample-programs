10 DIM A(99)
20 GOSUB 2000: REM Get array
25 REM Error if invalid or not end of input/value
30 IF V = 0 OR C >= 0 THEN GOTO 200
40 GOSUB 3000: REM Perform maximum subarray
50 S$ = STR$(BS)
60 IF BS >= 0 THEN S$ = MID$(S$, 2)
70 PRINT S$
80 END
200 Q$ = CHR$(34): REM quote
210 PRINT "Usage: Please provide a list of integers in the format: ";
220 PRINT Q$; "1, 2, 3, 4, 5"; Q$
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
3000 REM Find maximum subarray using Kadane's algorithm.
3001 REM Source:
3002 REM https://en.wikipedia.org/wiki/Maximum_subarray_problem
3003 REM #No_empty_subarrays_admitted
3004 REM Inputs:
3005 REM - A contains array
3006 REM - NA contains size of array
3007 REM Outputs: BS contains answer
3010 REM Initialize best sum to -infinity and current sum to 0
3020 BS = -1.70141183E38: REM (smallest negative number)
3030 CS = 0
3040 IF NA < 1 THEN BS = 0: GOTO 3130
3050 FOR I = 0 TO NA - 1
3060     REM If current sum < 0, set it to current value
3070     REM Else, add current value to current sum
3080     IF CS < 0 THEN CS = 0
3090     CS = CS + A(I)
3100     REM If current sum greater than best sum, update best sum
3110     IF CS > BS THEN BS = CS
3120 NEXT I
3130 RETURN
