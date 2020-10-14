factorial = (n) ->
    [1..n].reduce (x, y) -> x * y
    
console.log factorial(process.argv[2])
