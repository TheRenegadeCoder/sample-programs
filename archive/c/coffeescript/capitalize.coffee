Usage = "Usage: please provide a string"

main = () ->
    args = process.argv[2..].join(" ")
    if args
        args
    else 
        return Usage

console.log main()