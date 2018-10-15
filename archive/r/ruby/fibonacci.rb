def fibonacci(number)
    a = 0
    b = 1
    c = 0

    i = 0
    while i <= number
        c = a + b
        b = a
        a = c

        print("#{i}: #{c}\n")
        i += 1
    end
end

if ARGV.length < 1
    print("Usage: ruby fibonacci.rb NUMBER\n")
else
    fibonacci(ARGV[0].to_i)
end