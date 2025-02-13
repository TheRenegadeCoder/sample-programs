function err() 
    return "Usage: please input a non-negative integer"
 end
 

function isPrime(num)
# handle 0 and 1
    if num <= 1 
        return "composite"
    end 

# default handler
    for i in 2:sqrt(num) #loop starting at 2, ending at the squareroot of the input
        if (num % i == 0)
            return "composite"
        end
    end
    return "prime"             
end

#check for a valid input
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
