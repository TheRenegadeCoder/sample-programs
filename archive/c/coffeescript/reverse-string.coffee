reverseString = (arg) ->
    return arg
    
main = () ->
    args = process.argv[2]
    return reverseString(args)

console.log(main())