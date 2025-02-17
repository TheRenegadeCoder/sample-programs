-- fibonacci function
fibonacci = (n) ->
    a, b = 1, 1
    for i = 1, n
        print "#{i}: #{a}"
        a, b = b, a + b

-- main 
if tonumber(arg)
    fibonacci arg
else   
    print "Usage: please input the count of fibonacci numbers to output"
    