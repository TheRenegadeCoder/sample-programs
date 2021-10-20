args<-commandArgs(TRUE)
number = args[1]
numbers_only <- function(a) !grepl("\\D", number)

if (length(args) < 1 || numbers_only(number) == FALSE) {
  cat("Usage: please input a number")
}else {
  number = as.numeric(number)
  if (number %% 2 == 0) {
    cat("Even")
  }else {
    cat("Odd")
  }
}
