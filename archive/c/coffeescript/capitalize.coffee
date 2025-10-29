Usage = "Usage: please provide a string"

capitalize = (arg) ->
    return arg

main = () ->
    args = process.argv[2..].join(" ")
    if args
        capitalize(args)
    else 
        return Usage

console.log main()