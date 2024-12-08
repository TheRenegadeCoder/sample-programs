findLongestWord = (inputString) ->

  return usage() if not inputString

  words = inputString.split(/[" "\n]+/)  # Split the input string into words

  longestWord = ""

  for word in words
    if word.length > longestWord.length
      longestWord = word

  return longestWord.length
    
usage = () ->
    "Usage: please provide a string"
    
main = () ->
    args = process.argv
    return findLongestWord(args[2])
    

console.log main()


