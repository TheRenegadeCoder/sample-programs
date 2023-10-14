5 REM 
10 DIM A(99)
15 DIM SK(299): REM Need to potentially stack 3 values for each array element
20 GOSUB 2000: REM Get array
25 REM Error if invalid, not end of input/value, or less that 2 items
30 IF V = 0 OR C >= 0 OR NA < 2 THEN GOTO 200
40 SP = -1: GOSUB 3000: REM Perform quick sort
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
3000 REM Quick sort
3001 REM Commodore Basic does not really support recursion because everything
3002 REM is a global variable. However, recursion can be simulated with
3003 REM a "stack". This "stack" is just an array, SK, and a stack index, SP.
3004 REM Source:
3005 REM https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme
3006 REM Inputs:
3007 REM - A contains array to sort
3008 REM - NA contains size of array
3009 REM Outputs: A contains sorted array
3010 LO = 0
3020 HI = NA - 1
3030 REM Recursive portion of algorithm
3031 REM Inputs:
3032 REM - A contains array to sort
3033 REM - LO contains low index
3034 REM - HI contains high index
3035 REM Outputs: A contains partially sorted array
3040 IF LO >= HI OR LO < 0 THEN RETURN
3050 GOSUB 3300: REM Parition array and get pivot index (P)
3060 SP = SP + 1: SK(SP) = LO: REM Push LO
3070 SP = SP + 1: SK(SP) = HI: REM Push HI
3080 SP = SP + 1: SK(SP) = P: REM Push P
3090 HI = P - 1: GOSUB 3030: REM Sort left side of partition
3100 P = SK(SP): SP = SP - 1: REM Pop P
3110 HI = SK(SP): SP = SP - 1: REM Pop HI
3120 SP = SP + 1: SK(SP) = HI: REM Push HI
3130 SP = SP + 1: SK(SP) = P: REM Push P
3140 LO = P + 1: GOSUB 3030: REM Sort right side of partition
3150 SP = SP - 1: REM Pop P (don't store)
3160 HI = SK(SP): SP = SP - 1: REM Pop HI
3170 LO = SK(SP): SP = SP - 1: REM Pop LO
3180 RETURN
3300 REM Partition array
3301 REM Inputs:
3302 REM - A contains array to partition
3303 REM - LO contains low index
3304 REM - HI contains high index
3305 REM Outputs:
3306 REM - A contains partitioned array
3307 REM - P contains pivot index
3310 PV = A(HI): REM Choose last value as pivot
3320 P = LO - 1: REM Set temp pivot index
3325 REM Swap elements less than or equal to pivot, and increment temp index
3330 FOR J = LO TO HI - 1
3340     IF A(J) > PV THEN GOTO 3390
3350     P = P + 1
3360     T = A(J)
3370     A(J) = A(P)
3380     A(P) = T
3390 NEXT J
3395 REM Move pivot to correct position
3400 P = P + 1
3410 T = A(HI)
3420 A(HI) = A(P)
3430 A(P) = T
3440 RETURN
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
