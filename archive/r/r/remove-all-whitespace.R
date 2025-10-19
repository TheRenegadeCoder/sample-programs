# Remove all white spaces
args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0 || args[1] == "" || is.null(args[1]) ){
  cat("Error: Please provide a positive integer.")
}

n <- as.numeric(args[1])

if(is.na(n) || n < 1){
  cat("Error: Please provide a positive integer.")
  q(status=1)
} else if (n == 0){
  q(status = 1)
} else {
  num1 = 0
  num2 = 1
  num3 = 0
  i = 1
  while (i <= n) {
    num3 = num1 + num2
    num1 = num2
    num2 = num3
    cat(i, ":", num1,"\n")
    i = i +1
  }
}
