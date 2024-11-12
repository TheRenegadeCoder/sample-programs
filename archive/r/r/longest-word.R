#Given a string, this program should break it up into words and determine the length of the longest word.
#In this case, a word is defined as anything surrounded by whitespace.

find_longest <- function(string) {
    words <- strsplit(string, "\\s+")
    
    longest_word <- ""
    for (word in words) {
        if (nchar(word) > nchar(longest_word)) {
            longest_word <- word
        }
    }
  
  return(longest_word)
}

# Example usage
sentence <- "This is a sample sentence to find the longest word."
longest_word <- find_longest(sentence)
print(longest_word)