#!/usr/bin/julia

for i = 1:100
    str = i % 3 == 0 ? "Fizz" : ""
    str *= i % 5 == 0 ? "Buzz" : ""
    if isempty(str)
        str = i
    end
    println(str)
end
