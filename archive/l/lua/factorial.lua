
--
-- Calculate the factorial
--
factorial = function(num)
    product = 1
    if num > 1
    then
        for i = 2, num 
        do
            product = product * i
        end
    end
    return product
end

--
-- Main executable logic
--
main = function(input)
    maxInput = 20
    usage = "Usage: please input a non-negative integer"

    if not (input == nil or input == "")
    then
        inputValidation = input:gsub('[0-9]','')
        if inputValidation:len() == 0
        then
            inputNum = tonumber(input)
            if inputNum > maxInput
            then
                print('Input of ' .. inputNum .. ' is too large to calculate a factorial for. Max input is ' .. maxInput .. '.')
            else
                print(factorial(tonumber(input)))
            end
        else
            print(usage)
        end
    else
        print(usage)
    end

end

-- Run the script
main(arg[1])
