
removeAllWhitespace = (inputString) ->
    return usage() if not inputString
    words = inputString.split(/[\s]+/)
    finalString = ''
    for word in words
        finalString += word
    return finalString
usage = () ->
    "Usage: please provide a string"

main = () ->
    args = process.argv
    return removeAllWhitespace(args[2])

console.log main()
