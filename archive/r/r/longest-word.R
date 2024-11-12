longest_word_length <- function(input_string) {
  # Checking input
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) == 0 || args == "") {
    cat("Usage: please provide a string\n")
  } else {
    # Get the input string
    input_string <- args[1]
    
    # Split the input string by spaces, tabs, newlines, and carriage returns
    words <- unlist(strsplit(input_string, "[ \t\n\r]+"))
    
    # Find the length of the longest word
    if (length(words) == 0) {
      cat("Usage: please provide a string\n")
    } else {
      longest_word_length <- max(nchar(words))
      cat(longest_word_length, "\n")
    }
  }
}

longest_word_length()