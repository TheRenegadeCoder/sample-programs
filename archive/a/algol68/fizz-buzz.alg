FOR n FROM 1 TO 100
DO
    BOOL show number := TRUE;
    IF n MOD 3 = 0
    THEN
        print("Fizz");
        show number := FALSE
    FI;

    IF n MOD 5 = 0
    THEN
        print("Buzz");
        show number := FALSE
    FI;

    IF show number
    THEN
        print(whole(n, 0))
    FI;

    print(newline)
OD

