args<-commandArgs(TRUE)
number = args[1]
if (!is.numeric(number)) {
  cat("Usage: please input a number")
}else {
  if (number %% 2 == 0) {
    cat("even")
  }else {
    cat("odd")
  }
}
