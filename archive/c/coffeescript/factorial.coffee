factorial = (n) ->
    return 1 if n is 0
    [1..n].reduce (x, y) -> x * y
    
console.log factorial(process.argv[2])
