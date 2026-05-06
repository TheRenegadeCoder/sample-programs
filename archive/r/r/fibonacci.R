USAGE <- "Usage: please input the count of fibonacci numbers to output"
args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1 || nchar(args[1]) == 0) {
  cat(USAGE, "\n")
  quit(status = 1)
}

n <- suppressWarnings(as.numeric(args[1]))

if (is.na(n) || n %% 1 != 0) {
  cat(USAGE, "\n")
  quit(status = 1)
}

if (n <= 0) {
  quit(status = 0)
}

fib <- numeric(n)
fib[1] <- 1

if (n >= 2) {
  fib[2] <- 1
}

if (n >= 3) {
  for (i in 3:n) {
    fib[i] <- fib[i - 1] + fib[i - 2]
  }
}

indices <- 1:n
output <- paste0(indices, ": ", fib, collapse = "\n")
cat(output, "\n")