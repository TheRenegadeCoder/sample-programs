find_longest_word <- function(sentence) {
  # Split the sentence into words
  words <- strsplit(sentence, "\\s+")[[1]]
  
  # Find the longest word
  longest_word <- ""
  for (word in words) {
    if (nchar(word) > nchar(longest_word)) {
      longest_word <- word
    }
  }
  
  return(longest_word)
}
