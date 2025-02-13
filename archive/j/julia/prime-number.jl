function err() 
    println("Usage: please input a non-negative integer")
 end
 
function isPrime(num)
    if (num % 2 == 0 || num == 0 || num == 1) && (num != 2)
        return "composite"
    else
        return "prime"
    end
end

try
    n = parse(Int, ARGS[1])
    if n<0
        err()
    else
        println(isPrime(n))
    end
catch e
    err()
end
