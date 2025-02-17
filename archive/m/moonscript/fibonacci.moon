-- fibonacci function
fibonacci = (n) ->
    -- set up a, b, for i until n, print "i: n" then update a & b as the fibonacci sequence
    a, b = 1, 1
    for i = 1, n
        print "#{i}: #{a}"
        a, b = b, a + b

-- main
-- check if arg params are numbers and are greater than 0
if arg[1] and tonumber(arg[1]) ~= nil and tonumber(arg[1]) >= 0
    fibonacci tonumber(arg[1])
-- else, return usage error msg
else   
    print "Usage: please input the count of fibonacci numbers to output"
    