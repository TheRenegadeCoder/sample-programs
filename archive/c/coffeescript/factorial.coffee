factorial = (n) ->
    return 1 if n == "0"
    [1..n].reduce (x, y) -> x * y
    
main = () ->
    return factorial(process.argv[2]) if process.argv.length >= 2
    "Usage: please input a non-negative integer"
    
console.log main()
