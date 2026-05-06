args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1 || !nzchar(args[[1]])) {
  cat("Usage: please provide a string\n")
  quit(status = 1)
}

cat(gsub("\\s+", "", args[[1]]), "\n")