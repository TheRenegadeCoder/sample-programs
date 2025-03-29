10 C$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
20 GOSUB 1000: REM Get mode
30 M$ = S$
40 GOSUB 1000: REM Get string
50 IF S$ = "" THEN GOTO 170
60 IF M$ = "encode" THEN GOTO 90
70 IF M$ = "decode" THEN GOTO 120
80 GOTO 170
90 REM Base64 encode string
100 GOSUB 2000
110 GOTO 150
120 REM Base64 decode string
130 GOSUB 3000
140 IF E <> 0 THEN GOTO 170
150 PRINT R$
160 END
170 PRINT "Usage: please provide a mode and a string to encode/decode"
180 END
1000 REM Read input value one character at a time since Commodore BASIC
1001 REM has trouble reading line from stdin properly
1002 REM S$ = string
1003 REM Initialize
1010 S$ = ""
1015 REM Append characters until end of value or input
1020 GET A$
1030 C = ASC(A$)
1040 IF C = 13 OR C = 255 THEN RETURN: REM end of value or input
1050 S$ = S$ + A$
1060 GOTO 1020
2000 REM Base64 encode string
2001 REM Inputs:
2002 REM - C$ = Base64 characters
2003 REM - S$ = string to encode
2004 REM Output: R$ = encoded string
2010 R$ = ""
2020 L = LEN(S$)
2030 FOR N = 1 TO L STEP 3
2031     REM N1 = char code(S$[N])
2032     REM N2 = char code(S$[N + 1]) if N + 1 <= L else 0
2033     REM N3 = char code(S$[N + 2]) if N + 2 <= L else 0
2040     N1 = ASC(MID$(S$, N, 1))
2050     N2 = 0: IF N + 1 <= L THEN N2 = ASC(MID$(S$, N + 1, 1))
2060     N3 = 0: IF N + 2 <= L THEN N3 = ASC(MID$(S$, N + 2, 1))
2065     REM U = (N1 << 16) | (N2 << 8) | N3
2070     U = (N1 * 65536) + (N2 * 256) + N3
2071     REM R$ += Base64 chars[1 + (U >> 18)]
2072     REM R$ += Base64 chars[1 + ((U >> 12) & 0x3f)]
2073     REM R$ += Base64 chars[1 + ((U >> 6) & 0x3f)] if N + 1 <= L else "="
2074     REM R$ += Base64 chars[1 + (U & 0x3f)] if N + 2 <= L else "="
2080     D = 262144: REM D = 1 << 18
2090     FOR B = 0 TO 23 STEP 6
2100         GOSUB 2200
2110         D = INT(D / 64): REM D >>= 6
2120     NEXT B
2130 NEXT N
2140 RETURN
2200 REM Append Base64 character to result
2201 REM Inputs:
2202 REM - C$ = Base64 characters
2203 REM - U = 24-bit representation of 3 characters of input string
2204 REM - N = current string index
2205 REM - L = length of string to encode
2206 REM - D = divisor (2 ** number of shifts)
2207 REM - B = input string index in bits
2208 REM - R$ = current Base64 encoded string
2209 REM Output: R$ = new Base64 encoded string
2210 A$ = "="
2220 IF N + INT(B / 8) > L THEN GOTO 2250
2230 T = INT(U / D)
2240 A$ = MID$(C$, 1 + T - 64 * INT(T / 64), 1)
2250 R$ = R$ + A$
2260 RETURN
3000 REM Base64 decode string
3001 REM Inputs:
3002 REM - C$ = Base64 characters
3003 REM - S$ = string to decode
3004 REM Outputs:
3005 REM - R$ = encode string
3006 REM - E = 0 if no errors, 1 otherwise
3010 R$ = ""
3020 L = LEN(S$)
3025 REM P = number of trailing pad chars
3030 GOSUB 3300
3035 REM Error if string length not a multiple of 4 or more than 2 pad chars
3040 E = (L AND 3) <> 0 OR P > 2
3045 REM Trim trailing pad characters
3050 L = L - P
3060 N = 1
3070 IF N > L OR E <> 0 THEN GOTO 3220
3071 REM N1 = base64 index(S$[N])
3072 REM N2 = base64 index(S$[N + 1]) if N + 1 <= L else 0
3073 REM N3 = base64 index(S$[N + 2]) if N + 2 <= L else 0
3074 REM N4 = base64 index(S$[N + 3]) if N + 3 <= L else 0
3080 I = 0: GOSUB 3400: N1 = K
3090 I = 1: GOSUB 3400: N2 = K
3100 I = 2: GOSUB 3400: N3 = K
3110 I = 3: GOSUB 3400: N4 = K
3115 REM Error if invalid Base64 character
3120 E = (N1 < 0) OR (N2 < 0) OR (N3 < 0) OR (N4 < 0)
3130 IF E <> 0 THEN GOTO 3070
3135 REM U = (N1 << 18) | (N2 << 12) | (N3 << 6) | N4
3140 U = N1 * 262144 + N2 * 4096 + N3 * 64 + N4
3141 REM R$ += char(U >> 16)
3142 REM R$ += char((U >> 8) & 0xff) if N + 2 <= L else ""
3143 REM R$ += char(U & 0xff) if N + 3 <= L else ""
3150 D = 65536: REM D = 1 << 16
3160 FOR I = 1 TO 3
3170     GOSUB 3600
3180     D = INT(D / 256): REM D = D >> 8
3190 NEXT I
3200 N = N + 4
3210 GOTO 3070
3220 RETURN
3300 REM Count number of trailing pad characters
3301 REM Inputs:
3302 REM - S$ = Base64 string to decode
3303 REM - L = length of string
3304 REM Output: P = number of trailing pad characters
3310 I = L
3320 P = 0
3330 IF I < 1 OR MID$(S$, I, 1) <> "=" THEN GOTO 3370
3340 P = P + 1
3350 I = I - 1
3360 GOTO 3330
3370 RETURN
3400 REM Get Base64 index
3401 REM Inputs:
3402 REM - S$ = Base64 string to decode
3403 REM - N = current string index
3404 REM - I = input string offset in bytes
3405 REM - L = length in string
3406 REM Output: K = Base64 index if valid, -1 otherwise
3410 K = 0
3420 IF N + I > L THEN GOTO 3510
3430 A$ = MID$(S$, N + I, 1)
3440 K = ASC(A$)
3450 IF A$ >= "A" AND A$ <= "Z" THEN K = K - ASC("A"): GOTO 3510
3460 IF A$ >= "a" AND A$ <= "z" THEN K = K - ASC("a") + 26: GOTO 3510
3470 IF A$ >= "0" AND A$ <= "9" THEN K = K - ASC("0") + 52: GOTO 3510
3480 IF A$ = "+" THEN K = 62: GOTO 3510
3490 IF A$ = "/" THEN K = 63: GOTO 3510
3500 K = -1
3510 RETURN
3600 REM Append Base64 decoded character to result
3601 REM Inputs:
3602 REM - U = 24-bit representation of 4 Base64 indices of input string
3603 REM - N = current string index
3604 REM - L = length of string to encode
3605 REM - D = divisor (2 ** number of shifts)
3606 REM - I = input string index in bytes
3607 REM - R$ = current Base64 decoded string
3608 REM Output: R$ = new Base64 decoded string
3610 IF N + I > L THEN GOTO 3640
3620 T = INT(U / D)
3630 R$ = R$ + CHR$(T - 256 * INT(T / 256))
3640 RETURN
