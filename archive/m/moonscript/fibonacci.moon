-- fibonacci function
fibonacci = (n) ->
    a, b = 1, 1
    for i = 1, n
        print "#{i}: #{a}"
        a, b = b, a + b

-- main 
if arg[1] and tonumber(arg[1]) ~= nil and tonumber(arg[1]) >= 0
    fibonacci tonumber(arg[1])
else   
    print "Usage: please input the count of fibonacci numbers to output"
    