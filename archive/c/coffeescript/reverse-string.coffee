reverseString = (arg) ->
    reversed = ""
    if not arg
        return ""
    for char, i in arg
        reversed += arg[arg.length - 1 - i]
    return reversed

main = () ->
    args = process.argv[2]
    return reverseString(args)

console.log(main())