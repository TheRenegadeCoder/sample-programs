factorial = (n) ->
    return 1 if n == "0"
    [1..n].reduce (x, y) -> x * y
    
main = () ->
    args = process.argv
    return factorial(args[2]) if args.length == 3 and isFinite(args[2])
    "Usage: please input a non-negative integer"

console.log main()
