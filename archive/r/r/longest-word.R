longest_word_length <- function(input_string) {
  # Checking input
  args <- commandArgs(trailingOnly = TRUE)
  
  if (length(args) == 0 || args == "") {
    cat("Usage: please provide a string\n")
  } else {
    # Split the string by whitespace and find the maximum word length in one line
    cat(max(nchar(unlist(strsplit(args[1], "[ \t\n\r]+")))), "\n")
  }
}

longest_word_length()