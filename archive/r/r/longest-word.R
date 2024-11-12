#Given a string, this program should break it up into words and determine the length of the longest word.
#In this case, a word is defined as anything surrounded by whitespace.

find_longest_word <- function(sentence) {
  # Split the sentence into words
  words <- unlist(strsplit(sentence, "\\s+"))
  
  # Find the longest word
  longest_word <- words[which.max(nchar(words))]
  
  # Return the longest word
  return(longest_word)
}