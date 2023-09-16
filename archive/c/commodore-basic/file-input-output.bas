10 OPEN 1, 1, 1, "output.txt"
20 PRINT#1, "Hello from Commodore Basic"
30 PRINT#1, "This is a line"
40 PRINT#1, "This is another line"
50 PRINT#1, "Goodbye!"
60 CLOSE 1
70 OPEN 1, 1, 0, "output.txt"
80 INPUT#1, A$
90 PRINT A$
100 IF ST = 0 THEN GOTO 80
110 CLOSE 1
