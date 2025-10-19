# Palindromic Number
args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0 || args[1] = "" || is.null(args[1]) ){
  cat("Error: Please provide a positive integer.")
}

n <- as.numeric(args[1)

if(is.na(n) || n < 1){
  cat("Error: Please provide a positive integer.")
  q(status=1)
} else if (n == 0){
  q(status = 1)
} else {
  is_palindromic <- function(n) {
  str_n <- as.character(n)
  return(str_n == paste(rev(strsplit(str_n, "")[[1]]), collapse = "" ))
}
if (is_palindromic(n) ){
  cat("true")
}
else {
  cat("false)
}
}
