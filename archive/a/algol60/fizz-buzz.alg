begin
    integer procedure mod(x, n);
    value x, n;
    integer x, n;
    begin
        mod := x - n * (x % n)
    end mod;

    integer i;
    for i := 1 step 1 until 100 do
    begin
        if mod(i, 15) = 0 then outstring(1, "FizzBuzz")
        else if mod(i, 3) = 0 then outstring(1, "Fizz")
        else if mod(i, 5) = 0 then outstring(1, "Buzz")
        else outinteger(1, i);
        outstring(1, "\n")
    end
end
