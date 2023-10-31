10 DIM A(99)
15 REM Graph:
16 REM - G%(i, j, 0) contains vertex index for child node j,  vertex i or
17 REM   negative to indicate no more child nodes
18 REM - G%(i, j, 1) contains weight between vertex i and child node j
20 DIM G%(9, 10, 1)
25 REM Dijkstra result
26 REM - DR(i, 0) contains vertex index of previous node of node i
27 REM - DR(i, 1) contains distance between previous node of node i and node i
28 REM - DR(i, 2) contains 1 if node i visited, 0 otherwise
30 DIM DR(9, 2)
35 REM Get weights
40 GOSUB 2000
50 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
55 REM Get source node
60 GOSUB 1000
70 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
80 NS = NR
85 REM Get destination node
90 GOSUB 1000
100 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
110 ND = NR
115 REM Validate inputs
120 GOSUB 3000
130 IF V = 0 THEN GOTO 200: REM invalid inputs
135 REM Form graph
140 GOSUB 2500
145 REM Perform Dijkstra's algorithm and show result
150 GOSUB 3500
160 S$ = MID$(STR$(DR(ND, 1)), 2)
170 PRINT S$
180 END
200 PRINT "Usage: please provide three inputs: a serialized matrix, ";
210 PRINT "a source node and a destination node"
220 END
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
2502 REM - A contains weights
2504 REM - NV contains number of vertices
2505 REM Output: G% contains graph
2510 K = -1
2520 FOR I = 0 TO NV - 1
2530     N = -1
2540     FOR J = 0 TO NV - 1
2550         K = K + 1
2560         IF A(K) <= 0 THEN GOTO 2600
2570         N = N + 1
2580         G%(I, N, 0) = J
2590         G%(I, N, 1) = A(K)
2600     NEXT J
2610     G%(I, N + 1, 0) = -1: REM End of child nodes
2620     G%(I, N + 1, 1) = 0
2630 NEXT I
2640 RETURN
3000 REM Validate inputs
3001 REM Inputs:
3002 REM - A contains weights
3003 REM - NA contains number of weights
3004 REM - ND contains destination node
3005 REM - NS contains source node
3005 REM Outputs:
3006 REM - V is 1 if valid, 0 otherwise
3007 REM - NV contains the number of vertices
3010 V = 0: REM assume invalid
3020 REM Verify number of weights is a square
3030 NV = INT(SQR(NA) + 0.5)
3040 IF NA <> (NV * NV) THEN GOTO 3160
3055 REM Verify weights greater than zero, and at least one non-zero weight
3060 NZ = 0
3070 I = -1
3080 I = I + 1
3090 IF I >= NV THEN GOTO 3130
3100 IF A(I) < 0 THEN GOTO 3160
3110 IF A(I) <> 0 THEN NZ = 1: REM Non-zero weight found
3120 GOTO 3080
3130 IF NZ = 0 THEN GOTO 3160
3135 REM Verify source and destination node
3140 IF NS < 0 OR NS >= NV OR ND < 0 OR ND >= NV THEN GOTO 3160
3150 V = 1
3160 RETURN
3500 REM Dijkstra's algorithm
3501 REM Source:
3502 REM https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
3503 REM Inputs:
3504 REM - G% contains graph
3505 REM - NV contains number of vertices
3506 REM - NS contains source node
3507 REM Output: DR contains Dijkstra result
3510 REM Initialize distances to infinite and previous vertices to undefined
3511 REM Set source vertex distance to 0
3512 REM Indicate all nodes unvisited
3520 FOR I = 0 TO NV - 1
3530     DR(I, 0) = -1
3540     DR(I, 1) = 1.70141183E38: REM Infinity
3550     DR(I, 2) = 0
3560 NEXT I
3570 DR(NS, 1) = 0
3575 REM While any unvisited nodes
3580 FOR I = 0 TO NV - 1
3585     REM Pick a vertex u with minimum distance from unvisited nodes
3590     MD = 1.70141183E38: REM Infinity
3600     U = -1
3610     FOR J = 0 TO NV - 1
3620         IF DR(J, 2) <> 0 OR DR(J, 1) >= MD THEN GOTO 3650
3630         MD = DR(J, 1)
3640         U = J
3650     NEXT J
3655     REM Indicate vertex u visited
3660     DR(U, 2) = 1
3665     REM For each unvisited neighbor v of vertex u
3670     J = -1
3680     J = J + 1
3690     V = G%(U, J, 0)
3700     W = G%(U, J, 1)
3710     IF V < 0 THEN GOTO 3780
3720     IF DR(V, 2) <> 0 THEN GOTO 3680
3725     REM Get trial distance
3730     TD = DR(U, 1) + W
3735     REM If trial distance is smaller than distance v, update distance to
3736     REM v and previous vertex of v
3740     IF TD >= DR(V, 1) THEN GOTO 3680
3750     DR(V, 0) = U
3760     DR(V, 1) = TD
3770     GOTO 3680
3780 NEXT I
3790 RETURN
