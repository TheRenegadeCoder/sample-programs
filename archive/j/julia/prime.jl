#!/usr/bin/julia

function check(n)
    if n == 1
        println("Neither prime nor composite")
    elseif n == 0
        println(n, " is Composite")
    else
        for i = 2:Int(floor(sqrt(n)))
            if n % i == 0
                println(n ," is Composite")
                return
            end
        end
        println(n, " is Prime")
    end
end

@time check(9)
