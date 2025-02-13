function err() 
    return "Usage: please input a non-negative integer"
 end
 
function isPrime(num)
    if num <= 1 
        return "composite"
    end 
    for i in 2:sqrt(num)
        if (num % i == 0)
            return "composite"
        end
    end
    return "prime"             
end

try
    n = parse(Int, ARGS[1])
    if n < 0
        println(err())
    else
        println(isPrime(n))
    end
catch e
    println(err())
end
