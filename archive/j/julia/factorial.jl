#!/usr/bin/julia

function err() 
   println("Usage: please input a non-negative integer")
end

function fac(n)
    if n < 0
        err()
        exit()
    end
        
    out = 1
    for i = 1:n
        out = out * i
    end
    return out
end

try
    println(fac(parse(Int, ARGS[1])))
catch e
    err()
end
