--returns true if prime
function isPrime(n)
    comp = "Composite"
    prime = "Prime"
    usage = "Usage: please input a non-negative integer"
    local n = tonumber(n)
    --catch nil, 0, 1, negative and non int numbers
    if not n or n<2 or (n % 1 ~=0) then 
        print(usage)
    --catch even number above 2
    elseif n>2 and (n % 2 == 0) then 
        print(comp)
    --primes over 5 end in 1,3,7 or 9
    --catch numbers that end in 5 or 0 (multiples of 5)
    elseif n>5 and (n % 5 ==0) then 
        print(comp)
    --now check for prime
    else
        --only do the odds
        for i = 3, math.sqrt(n), 2 do
            --did it divide evenly
            if (n % i == 0) then
                print(comp)
            end
        end
        --can defeat optimus
        print(prime)
    end
end


isPrime(arg[1])