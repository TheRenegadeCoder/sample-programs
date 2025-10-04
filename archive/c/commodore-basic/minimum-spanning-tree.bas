10 DIM A(99)
15 REM Graph:
16 REM - G%(i, j, 0) contains vertex index for child node j,  vertex i or
17 REM   negative to indicate no more child nodes
18 REM - G%(i, j, 1) contains weight between vertex i and child node j
20 DIM G%(9, 10, 1)
25 REM Minimum spanning tree working values
30 DIM MP%(9): REM Parents
40 DIM MK(9): REM Keys
50 DIM MS%(9): REM Set
55 REM Minimum spanning tree output
56 REM - MT(i, 0) contains source vertex index for node i
57 REM - MT(i, 1) contains destination vertex index for node i
58 REM - MT(i, 2) contains weight between source and destination for node i
60 DIM MT%(8, 2)
65 REM Get weights
70 GOSUB 2000
80 IF V = 0 OR C >= 0 THEN GOTO 200: REM invalid or not end of input/value
85 REM Get number of vertices
90 NV = INT(SQR(NA) + 0.5)
100 IF NA <> (NV * NV) THEN GOTO 200: REM non-square input
105 REM Form graph
110 GOSUB 2500
115 REM Perform minimum spanning tree, calculate total weight, and display
120 GOSUB 3000
130 GOSUB 3500
140 S$ = MID$(STR$(TW), 2)
150 PRINT S$
160 END
200 PRINT "Usage: please provide a comma-separated list of integers"
210 END
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
3000 REM Prim's Minimum Spanning Tree (MST) Algorithm based on C
3001 REM implementation of https://www.geeksforgeeks.org/
3002 REM prims-minimum-spanning-tree-mst-greedy-algo-5/
3003 REM Inputs:
3004 REM - G% contains graph
3005 REM - NV contains number of vertices
3006 REM Outputs:
3007 REM - MT contains minimum spanning tree
3008 REM - NM contains size of minimum spanning tree
3010 REM Initialize
3020 FOR I = 0 TO NV - 1
3030     MP%(I) = -1: REM No parents yet
3040     MK(I) = 1.70141183E38: REM Minimum weight edge is infinty
3050     MS%(I) = 0: REM Nothing in MST yet
3060 NEXT I
3065 REM Include first vertex in MST
3070 MK(0) = 0
3075 REM The MST will include all vertices
3080 FOR I = 1 TO NV - 1
3085     REM Pick index of the minimum key value not already in MST
3090     MV = 1.70141183E38: REM Minimum value is infinity
3100     U = -1
3110     FOR J = 0 TO NV - 1
3120         IF MK(J) >= MV OR MS%(J) <> 0 THEN GOTO 3150
3130         MV = MK(J)
3140         U = J
3150     NEXT J
3155     REM Add picked vertex to MST
3160     MS%(U) = 1
3165     REM Update key values and parent indices of picked adjacent vertices.
3166     REM Only consider vertices not yet in MST
3170     J = -1
3180     J = J + 1
3190     V = G%(U, J, 0)
3200     W = G%(U, J, 1)
3210     IF V < 0 THEN GOTO 3260
3220     IF MS%(V) <> 0 OR W >= MK(V) THEN GOTO 3180
3230     MP%(V) = U
3240     MK(V) = W
3250     GOTO 3180
3260 NEXT I
3265 REM Construct MST information to return, skipping over root
3270 NM = NV - 1
3280 FOR I = 1 TO NM
3290     MT(I - 1, 0) = MP%(I)
3300     MT(I - 1, 1) = I
3310     MT(I - 1, 2) = MK(I)
3320 NEXT I
3330 RETURN
3500 REM Calculate total weight of MST
3501 REM Inputs:
3502 REM - MT contains minimum spanning tree
3503 REM - NM contains size of minimum spanning tree
3504 REM Output: TW contains total weight
3510 TW = 0
3520 FOR I = 0 TO NM - 1
3530     TW = TW + MT(I, 2)
3540 NEXT I
3550 RETURN
