#!/usr/bin/julia

function fib(n)
    f = BigInt[1 1; 1 0]
    for i = 1:n
        fn = f ^ i
        println(i, ": ", fn[2, 1])
    end
end

function error() 
   println("Usage: please input the count of fibonacci numbers to output") 
end

try
    fib(parse(Int, ARGS[1]))
catch e
    error()
end

