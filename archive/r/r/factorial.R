args<-commandArgs(TRUE)
if(length(args) > 0){
  a = args[1]
  # Check if String or numeral only, ..
  numbers_only <- function(a) !grepl("\\D", a)
  if(numbers_only(a) == TRUE){
  if(a == 0){
    cat("1")
  }else if (a > 0){
  fact = 1
  for(i in 1:a){
    fact = fact * i
  }
  cat(fact)
  # else a < 0
    } else{
      cat("Usage: please input a non-negative integer")
          }
  #  Negative Input
  }else{
    cat("Usage: please input a non-negative integer")
     }
# Empty Command Line Param
}else{
    cat("Usage: please input a non-negative integer")
     }
