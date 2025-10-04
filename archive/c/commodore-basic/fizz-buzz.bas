10 FOR I = 1 TO 100
20     S$ = ""
30     IF (I - INT(I / 3) * 3) = 0 THEN S$ = S$ + "Fizz"
40     IF (I - INT(I / 5) * 5) = 0 THEN S$ = S$ + "Buzz"
45     REM STR$(I) prepends a space for positive numbers. MID$ removes it
50     IF S$ = "" THEN S$ = S$ + MID$(STR$(I), 2)
60     PRINT S$
70 NEXT I
