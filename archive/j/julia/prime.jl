#!/usr/bin/julia

function check(n)
    if n == 1
        println("Neither prime nor composite")
    elseif n == 0
        println(n, " is Composite")
    elseif n > 1
        for i = 2:(n/2)
            if n % i == 0
                println(n ," is Composite")
                return
            end
        end
        println(n, " is Prime")
    else
        println("Invalid input")
    end
end

check(9)
