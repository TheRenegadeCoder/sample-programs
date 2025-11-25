fibonacci <- function(n) {
  if (n < 0) {
    stop("Error: input must be a non-negative integer")
  }
  if (n == 0) return(0)
  if (n == 1) return(1)

  a <- 0
  b <- 1

  for (i in 2:n) {
    temp <- a + b
    a <- b
    b <- temp
  }
  return(b)
}

# Main
args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  cat("Usage: please provide a number\n")
  quit(status = 1)
}

n <- as.numeric(args[1])

if (is.na(n) || n < 0 || floor(n) != n) {
  cat("Usage: please provide a non-negative integer\n")
  quit(status = 1)
}

cat(fibonacci(n))
