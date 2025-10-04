#!/usr/bin/julia

function main()
    for i = 0:10
        print(" "^(10 - i))
        println("*"^(i * 2 + 1))
    end 

    for i = 9:-1:0
        print(" "^(10 - i))
        println("*"^(i * 2 + 1))
    end
end

main()
