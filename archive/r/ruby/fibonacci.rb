def fibonacci(number)
    a = 0
    b = 1
    c = 0

    i = 0
    while i < number
        c = a + b
        b = a
        a = c

        print("#{i+1}: #{c}\n")
        i += 1
    end
end

num = Integer(ARGV[0]) rescue -1
if num >= 0
    fibonacci(num)
else
    print("Usage: please input the count of fibonacci numbers to output")
end