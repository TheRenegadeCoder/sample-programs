args<-commandArgs(TRUE)
number = args[1]

if (length(args) < 1 || !suppressWarnings(!is.na(as.numeric(number)))) {
  cat("Usage: please input a number")
}else {
  number = as.numeric(number)
  if (number %% 2 == 0) {
    cat("Even")
  }else {
    cat("Odd")
  }
}
