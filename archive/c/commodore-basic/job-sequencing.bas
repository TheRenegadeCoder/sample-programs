10 DIM A(99)
15 REM Job info:
16 REM - JB(i, 0) = job index for slot i
17 REM - JB(i, 1) = profit for slot i
18 REM - JB(i, 2) = deadline for slot i
20 DIM JB(99, 2)
25 REM Slots (assumes maximum deadline is 100 or smaller
26 REM - SL(i, 0) = job index for deadline i + 1 or 0 if unoccupied
27 REM - SL(i, 1) = profit of deadline i + 1 or 0 if unoccupied
28 REM - SL(i, 2) = deadline for deadline i + 1 of 0 if unoccupied
30 DIM SL(99, 2)
35 REM Get profits
40 GOSUB 2000
50 IF V = 0 OR C <> -1 THEN GOTO 300: REM invalid or not end of value
60 NJ = NA
70 FOR I = 0 TO NA - 1
80    JB(I, 0) = I + 1
90    JB(I, 1) = A(I)
100 NEXT I
110 REM Get deadlines
120 GOSUB 2000
130 IF V = 0 OR C >= 0 THEN GOTO 300: REM invalid or not end of input/value
140 IF NA <> NJ THEN GOTO 300: REM Different number of profits and deadlines
150 FOR I = 0 TO NA - 1
160     JB(I, 2) = A(I)
170 NEXT I
175 REM Perform job sequencing, get total profit, and display
180 GOSUB 2500
190 GOSUB 3500
200 S$ = STR$(TP)
210 IF TP >= 0 THEN S$ = MID$(S$, 2)
220 PRINT S$
230 END
300 PRINT "Usage: please provide a list of profits and a list of deadlines"
310 END
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
2500 REM Perform job sequencing with deadlines
2501 REM Source:
2502 REM https://www.techiedelight.com/job-sequencing-problem-deadlines/
2503 REM Inputs:
2504 REM - JB contains jobs to sort
2505 REM - NJ contains number of jobs
2506 REM Outputs:
2507 REM - SL contains slots
2508 REM - MD contains maximum deadline
2510 REM Get maximum deadline
2520 MD = 0
2530 IF NJ < 1 THEN RETURN
2540 FOR I = 0 TO NJ - 1
2550     IF JB(I, 2) > MD THEN MD = JB(I, 2)
2560 NEXT I
2565 REM Initialize slots
2570 FOR I = 0 TO MD - 1
2580     FOR K = 0 TO 2
2590         SL(I, K) = 0
2600     NEXT K
2610 NEXT I
2615 REM Sort jobs descending by profit, then deadline
2620 GOSUB 3000
2625 REM For each job, see if there is available slot at or before the deadline.
2626 REM If so, store this job in that slot
2630 FOR I = 0 TO NJ - 1
2640     J = JB(I, 2)
2650     J = J - 1
2660     IF J < 0 THEN GOTO 2710: Skip over expired deadlines
2670     IF SL(J, 0) > 0 THEN GOTO 2650: Skip over occupied slots
2680     FOR K = 0 TO 2
2690         SL(J, K) = JB(I, K)
2700     NEXT K
2710 NEXT I
2720 RETURN
3000 REM Bubble sort jobs descending by profit, then deadline
3001 REM Inputs:
3002 REM - JB contains jobs to sort
3003 REM - NJ contains number of jobs
3004 REM Outputs: JB contains sorted jobs
3010 I = -1
3020 I = I + 1
3030 IF I >= (NJ - 1) THEN GOTO 3160
3040 SW = 0: REM Indicate not swapped
3050 FOR J = I + 1 TO NJ - 1
3060     IF JB(I, 1) >= JB(J, 1) THEN GOTO 3140
3070     IF JB(I, 1) = JB(J, 1) AND JB(I, 2) >= JB(J, 2) THEN GOTO 3140
3080     FOR K = 0 TO 2
3090         T = JB(I, K)
3100         JB(I, K) = JB(J, K)
3110         JB(J, K) = T
3120     NEXT K
3130     SW = 1: REM Indicate swapped
3140 NEXT J
3150 IF SW <> 0 THEN GOTO 3020
3160 RETURN
3500 REM Calculate total profit
3501 REM Inputs:
3502 REM - SL contains slots
3503 REM - MD contains maximum deadline
3504 REM Output: TP contains total profit
3510 TP = 0
3520 IF MD < 1 THEN GOTO 3560
3530 FOR I = 0 TO MD - 1
3540     TP = TP + SL(I, 1)
3550 NEXT I
3560 RETURN
