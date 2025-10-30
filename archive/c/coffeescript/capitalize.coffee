Usage = "Usage: please provide a string"

capitalize = (arg) ->
    charList = []
    for char, i in arg
        if i == 0
            charList.push(char.toUpperCase())
        else
            charList.push(char)
    return charList.join("")

main = () ->
    args = process.argv[2]
    if args
        capitalize(args)
    else 
        return Usage

console.log main()