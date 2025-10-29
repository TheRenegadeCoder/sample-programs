Usage = "Usage: please provide a string"

capitalize = (arg) ->
    wordsList = []
    
    for word, i in arg
        if i == 0
            wordsList.push(word.toUpperCase())
        else
            wordsList.push(word)

    return wordsList.join("")

main = () ->
    args = process.argv[2..].join(" ")
    if args
        capitalize(args)
    else 
        return Usage

console.log main()