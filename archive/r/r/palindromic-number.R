args <- commandArgs(trailingOnly = TRUE)

USAGE <- "Usage: please input a non-negative integer"

if (length(args) != 1 || !nzchar(x <- args[[1]]) || !grepl("^[0-9]+$", x)) {
  cat(USAGE, "\n")
  quit(status = 1)
}

n <- as.numeric(x)
orig <- n
rev_num <- 0

while (n > 0) {
  rev_num <- rev_num * 10 + (n %% 10)
  n <- n %/% 10
}

cat(tolower(orig == rev_num), "\n")