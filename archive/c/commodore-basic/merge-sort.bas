10 DIM A(99)
15 DIM B(99): REM Work array
20 GOSUB 2000: REM Get array
25 REM Error if invalid, not end of input/value, or less that 2 items
30 IF V = 0 OR C >= 0 OR NA < 2 THEN GOTO 200
40 GOSUB 3000: REM Perform merge sort
50 GOSUB 3500: REM Show array
60 END
200 Q$ = CHR$(34): REM quote
210 PRINT "Usage: please provide a list of at least two integers to sort ";
220 PRINT "in the format "; Q$; "1, 2, 3, 4, 5"; Q$
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
3000 REM Merge sort
3001 REM Source:
3002 REM https://en.wikipedia.org/wiki/Merge_sort#Bottom-up_implementation
3003 REM Inputs:
3004 REM - A contains array to sort
3005 REM - NA contains size of array
3006 REM Output: A contains sorted array
3010 W = 1
3020 IF W >= NA THEN RETURN
3030 FOR IL = 0 TO NA - 1 STEP W * 2
3040     IR = IL + W
3050     IE = IR + W
3060     IF IR > NA THEN IR = NA
3070     IF IE > NA THEN IE = NA
3080     GOSUB 3200
3090 NEXT IL
3100 FOR I = 0 TO NA - 1
3110     A(I) = B(I)
3120 NEXT I
3130 W = W * 2
3140 GOTO 3020
3200 REM Merge array and work array
3201 REM Inputs:
3202 REM - A contains array to sort
3203 REM - NA contains size of array
3204 REM - IL contains left index
3205 REM - IR contains right index
3206 REM - IE contains end index
3207 REM Outputs: B contains sorted portion of work array
3210 II = IL
3220 JJ = IR
3230 FOR K = IL TO IE - 1
3240     IF II < IR AND (JJ >= IE OR A(II) <= A(JJ)) THEN GOTO 3280
3250     B(K) = A(JJ)
3260     JJ = JJ + 1
3270     GOTO 3300
3280     B(K) = A(II)
3290     II = II + 1
3300 NEXT K
3310 RETURN
3500 REM Display array
3501 REM A contains array
3502 REM NA contains size of array
3510 IF NA < 1 THEN GOTO 3590
3520 FOR I = 0 TO NA - 1
3530    S$ = STR$(A(I))
3540    IF A(I) >= 0 THEN S$ = MID$(S$, 2): REM strip leading space
3550    PRINT S$;
3560    IF I < (NA - 1)THEN PRINT ", ";
3570 NEXT I
3580 PRINT
3590 RETURN
