FOR n FROM 1 TO 100
DO
    STRING s := (n MOD 3 = 0 | "Fizz" | "");
    s +:= (n MOD 5 = 0 | "Buzz" | "");
    printf(($gl$, (s /= "" | s | whole(n, 0))))
OD
