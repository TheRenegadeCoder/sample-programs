args <- commandArgs(trailingOnly = TRUE)

USAGE <- "Usage: please provide a string"

if (length(args) != 1 || !nzchar(x <- args[[1]])) {
  cat(USAGE, "\n")
  quit(status = 1)
}

chars <- strsplit(x, "")[[1]]
chars <- chars[grepl("[[:alnum:]]", chars)]

if (!length(chars)) {
  cat("No duplicate characters\n")
  quit(status = 0)
}

counts <- table(chars)

dups <- counts[counts > 1]
dups <- dups[order(match(names(dups), chars))]

if (!length(dups)) {
  cat("No duplicate characters\n")
} else {
  cat(paste(names(dups), dups, sep = ": "), sep = "\n")
}