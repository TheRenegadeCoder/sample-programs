10 DIM M%(99, 99): REM Match array
20 GOSUB 1000: REM Input string
30 IF S$ = "" THEN GOTO 200
40 GOSUB 2000: REM Get longest palindromic substring
50 IF LEN(R$) < 2 THEN GOTO 200
60 PRINT R$
70 END
200 PRINT "Usage: please provide a string that contains at least ";
210 PRINT "one palindrome"
220 END
1000 REM Read input value one character at a time since Commodore BASIC
1001 REM has trouble reading line from stdin properly
1002 REM S$ = string
1003 REM Initialize
1010 S$ = ""
1015 REM Append characters until end of input
1020 GET A$
1030 C = ASC(A$)
1040 IF C = 13 OR C = 255 THEN RETURN: REM end of value or input
1050 S$ = S$ + A$
1060 GOTO 1020
2000 REM Find longest palindromic substring using matching array
2001 REM Source:
2002 REM https://www.geeksforgeeks.org/
2003 REM longest-palindromic-substring-using-dynamic-programming/
2004 REM Inputs: S$ contains string
2005 REM Outputs:
2006 REM - R$ contains longest palindromic substring
2010 REM Indicate all length 1 strings match and everything else does not
2020 N = LEN(S$)
2030 ML% = 1: REM Maximum length
2040 SI% = 1: REM Start index
2050 IF N < 1 THEN GOTO 2420
2060 FOR I = 0 TO N - 1
2070     FOR J = 0 TO N - 1
2080         M%(I, J) = 0
2090     NEXT J
2100     M%(I, I) = 1
2110 NEXT I
2120 REM Convert string to lowercase
2130 T$ = ""
2140 FOR I = 1 TO N
2150    C$ = MID$(S$, I, 1)
2160    IF C$ >= "A" AND C$ <= "Z" THEN C$ = CHR$(ASC(C$) + 32)
2170    T$ = T$ + C$
2180 NEXT I
2190 REM Find all length 2 matches
2200 IF N < 2 THEN GOTO 2420
2210 FOR I = 0 TO N - 2
2220     IF MID$(T$, I + 1, 1) <> MID$(T$, I + 2, 1) THEN GOTO 2270
2230     M%(I, I + 1) = 1
2240     IF ML >= 2 THEN GOTO 2270
2250     ML% = 2
2260     SI% = I + 1
2270 NEXT I
2280 REM Find all length 3 or higher matches
2290 IF N < 3 THEN GOTO 2420
2300 FOR L = 3 TO N
2310     REM Loop through each starting character
2320     FOR I = 0 TO N - L
2330         J = I + L - 1
2340         IF M%(I + 1, J - 1) = 0 THEN GOTO 2400
2350         IF MID$(T$, I + 1, 1) <> MID$(T$, J + 1, 1) THEN GOTO 2400
2360         M%(I, J) = 1
2370         IF L <= ML% THEN GOTO 2400
2380         ML% = L
2390         SI% = I + 1
2400     NEXT I
2410 NEXT L
2420 R$ = MID$(S$, SI%, ML%)
2430 RETURN
