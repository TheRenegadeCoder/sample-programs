FOR n FROM 1 TO 100
DO
    IF n MOD 3 = 0
    THEN
        print((n MOD 5 = 0 | "FizzBuzz" | "Fizz"))
    ELIF n MOD 5 = 0
    THEN
        print("Buzz")
    ELSE
        print(whole(n, 0))
    FI;

    print(newline)
OD

