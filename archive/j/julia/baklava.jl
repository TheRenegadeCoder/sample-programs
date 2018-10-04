#!/usr/bin/julia

function main()
    for i = 1:10
        print(" "^(10 - i))
        println("*"^(i * 2 - 1))
    end 

    for i = 1:9
        print(" "^(i))
        println("*"^((10 - i) * 2 - 1))
    end
end

main()
