Usage = "Usage: please provide a string"

main = () ->
    args = process.argv
    if args[2]?
        args[2] 
    else 
        Usage
   

console.log main()