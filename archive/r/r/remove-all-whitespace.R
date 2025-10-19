# Remove all white spaces
args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0 || args[1] == "" || is.null(args[1]) ){
  cat("Usage: please provide a string")
}

cleaned_sentence <- gsub("\\s+", "", args[1])

cat (cleaned_sentence)
