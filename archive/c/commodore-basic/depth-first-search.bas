10 DIM A(99)
15 REM Adjacency matrix
20 DIM AM%(99)
25 REM Vertices
30 DIM VX(9)
35 REM Graph:
36 REM - G%(i, j) contains vertex index for child node j,  vertex i or
37 REM   negative to indicate no more child nodes
40 DIM G%(9, 10)
45 REM Visited nodes: 1 if visited, 0 otherwise
50 DIM VS%(9)
55 REM Stack - 2 elements for vertex
60 DIM SK%(19)
65 REM Get adjacency matrix
70 GOSUB 2000
80 IF V = 0 OR C <> -1 THEN GOTO 400: REM invalid or end of input/value
90 NM = NA
100 FOR I = 0 TO NA - 1
110     AM%(I) = 0
120     IF A(I) <> 0 THEN AM%(I) = 1
130 NEXT I
135 REM Get vertices
140 GOSUB 2000
150 IF V = 0 OR C <> -1 THEN GOTO 400: REM invalid or end of input/value
160 NV = NA
170 FOR I = 0 TO NA - 1
180     VX(I) = A(I)
190 NEXT I
195 REM Get target value
200 GOSUB 1000
210 IF V = 0  OR C >= 0 THEN GOTO 400: REM invalid or not end of input/value
220 T = NR
225 REM Form graph
230 GOSUB 2500
235 REM Perform depth search and show result
240 SP = -1: REM Reset stack pointer
250 GOSUB 3000
260 R$ = "false"
270 IF VI >= 0 THEN R$ = "true"
280 PRINT R$
290 END
400 Q$ = CHR$(34): REM quote
410 PRINT "Usage: please provide a tree in an adjacency matrix form ";
420 PRINT "("; Q$; "0, 1, 1, 0, 0, 1, 0, 0, 0, 0, ";
430 PRINT "1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0"; Q$; ") ";
440 PRINT "together with a list of vertex values ";
450 PRINT "("; Q$; "1, 3, 5, 2, 4"; Q$;  ") and the integer to find ";
460 PRINT "("; Q$; "4"; Q$; ")"
470 END
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
2500 REM Form graph
2501 REM Inputs:
2502 REM - AM% contains adjacency matrix
2503 REM - NM contains number of items in adjacency matrix
2504 REM - NV contains number of vertices
2505 REM Output: G% contains graph
2510 K = -1
2520 FOR I = 0 TO NV - 1
2530     N = -1
2540     FOR J = 0 TO NV - 1
2550         K = K + 1
2560         IF K >= NM THEN GOTO 2600
2570         IF AM%(K) = 0 THEN GOTO 2600
2580         N = N + 1
2590         G%(I, N) = J
2600     NEXT J
2610     G%(I, N + 1) = -1: REM End of child nodes
2620 NEXT I
2630 RETURN
3000 REM Perform depth first search
3001 REM Commodore Basic does not really support recursion because everything
3002 REM is a global variable. However, recursion can be simulated with
3003 REM a "stack". This "stack" is just an array, SK, and a stack index, SP.
3004 REM Inputs:
3005 REM - VX contains vertices
3006 REM - NV contains number of vertices
3007 REM - T contains value to find
3008 REM - G% contains graph
3009 REM Output: VI contains index of vertex found, -1 if not found
3010 REM Initialize visited nodes
3020 FOR I = 0 TO NV - 1
3030     VS%(I) = 0
3040 NEXT I
3050 REM Start at root node
3060 NI = 0
3070 VI = -1
3100 REM Recursive portion of algorithm
3101 REM Inputs:
3102 REM - NI contains node index
3103 REM - VX contains vertices
3104 REM - NV contains number of vertices
3105 REM - T contains value to find
3106 REM - G% contains graph
3107 REM - VS% contains visited nodes
3108 REM Output: VI contains index of vertex found, -1 if not found
3110 IF VX(NI) = T THEN VI = NI: GOTO 3250: REM Found
3120 VS%(NI) = 1: REM Indicate node visited
3130 J = -1
3140 J = J + 1
3150 CI = G%(NI, J): REM Get child node
3160 IF CI < 0 THEN GOTO 3250: REM No more child nodes
3170 IF VS%(CI) <> 0 THEN GOTO 3140: REM Skip visited node
3180 SP = SP + 1: SK%(SP) = J: REM Push child node index
3190 SP = SP + 1: SK%(SP) = NI: REM Push node index
3200 NI = CI: REM Go to child node
3210 GOSUB 3100: REM Perform depth first search on child node
3220 NI = SK%(SP): SP = SP - 1: REM Pop node index
3230 J = SK%(SP): SP = SP - 1: REM Pop child node index
3240 IF VI < 0 THEN GOTO 3140: REM If not found, go to next child node
3250 RETURN
