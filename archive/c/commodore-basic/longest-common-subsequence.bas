10 DIM A(31)
15 REM Storage for lists
20 DIM L1(31), L2(31)
25 REM Storage for subsequences:
26 REM - C%(i, j, 0) contains length of subsequence
27 REM - C%(i, j, 1:2) contains bitmap indicating which indices of first list
28 REM   are in the subsequence
30 DIM C%(32, 32, 2)
35 REM Bit 0 to 15
40 DATA 1, 2, 4, 8, 16, 32, 64, 128
50 DATA 256, 512, 1024, 2048, 4096, 8192, 16384, -32768
60 DIM WM%(15)
70 FOR I = 0 TO 15
80     READ WM%(I)
90 NEXT I
95 REM Get list 1
100 GOSUB 2000
110 IF V = 0 OR C >= 0 THEN 300: REM invalid or not end of input/value
120 M = NA
130 FOR I = 0 TO NA - 1
140     L1(I) = A(I)
150 NEXT I
155 REM Get list 2
160 GOSUB 2000
170 IF V = 0 OR C >= 0 THEN 300: REM invalid or not end of input/value
180 N = NA
190 FOR I = 0 TO NA - 1
200     L2(I) = A(I)
210 NEXT I
215 REM Find longest common subsequence and display
220 GOSUB 3000
230 GOSUB 3500
240 END
300 Q$ = CHR$(34): REM quote
310 PRINT "Usage: please provide two lists in the format ";
320 PRINT Q$; "1, 2, 3, 4, 5"; Q$
330 END
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
3000 REM Longest common subsequence
3001 REM Source:
3002 REM https://en.wikipedia.org/wiki/Longest_common_subsequence#Example_in_C#
3003 REM Instead of storing just lengths, a bitmap indicating the indices of
3004 REM the first list is also stored
3005 REM Inputs:
3006 REM - L1 contains first list
3007 REM - M contains length of first list
3008 REM - L2 contains second list
3009 REM - N contains length of second list
3010 REM - WM% contains 16-bit words
3011 REM Outputs:
3012 REM - A contains subsequence
3013 REM - NA contains length of subsequence
3020 NA = 0
3030 IF M < 1 OR N < 1 THEN RETURN: REM exit if empty lists
3035 REM Initialize all subsequences to an empty sequence
3040 NW = INT((M + 15) / 16): REM Number of 16-bit words
3050 FOR I = 0 TO M
3060     FOR J = 0 TO N
3070         FOR K = 0 TO NW
3080             C%(I, J, K) = 0
3090         NEXT K
3100     NEXT J
3110 NEXT I
3115 REM Find the longest common subsequence using prior subsequences
3120 FOR I = 1 TO M
3130     FOR J = 1 TO N
3140         IF L1(I - 1) <> L2(J - 1) THEN GOTO 3230
3145         REM If common element found, create new subsequence based on
3146         REM prior subsequence with the common element appended
3150         C%(I, J, 0) = C%(I - 1, J - 1, 0) + 1
3160         FOR K = 1 TO NW
3170             C%(I, J, K) = C%(I - 1, J - 1, K)
3180         NEXT K
3190         WI = INT((I - 1) / 16): REM Word index
3200         BN = (I - 1) - 16 * WI: REM Bit number
3210         C%(I, J, WI + 1) = C%(I, J, WI + 1) OR WM%(BN)
3220         GOTO 3280
3230         REM Else, reuse the longer of the two prior subsequences
3240         II = I - 1: JJ = J
3240         IF C%(I, J - 1, 0) > C%(I - 1, J, 0) THEN II = I: JJ = J - 1
3250         FOR K = 0 TO NW
3260             C%(I, J, K) = C%(II, JJ, K)
3270         NEXT K
3280     NEXT J
3290 NEXT I
3295 REM Construct longest common subsequence from bitmap
3300 NA = 0
3310 NL = -1
3320 FOR WI = 0 TO NW - 1
3330     FOR BN = 0 TO 15
3340         NL = NL + 1
3350         IF (C%(M, N, WI + 1) AND WM%(BN)) = 0 THEN GOTO 3380
3360         A(NA) = L1(NL)
3370         NA = NA + 1
3380     NEXT BN
3390 NEXT WI
3400 RETURN
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
