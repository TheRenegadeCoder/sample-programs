# Program to check if the input number is prime or not
args<-commandArgs(TRUE)
if(length(args) > 0){
  a1 = args[1]
  # Check Numeral only, ..
  numbers_only <- function(a) !grepl("\\D", a1)
  if(numbers_only(a1) == TRUE){
    if (a1 >= 0){
      a = as.integer(a1)
    if(a == 2){
      cat("Prime")
      # If 0, or 1 or Even Number
    }else if (a == 0 || a == 1 || a %% 2 == 0 ) {
      cat("Composite")
    }else{
      flag = 1
      r = a %/% 2
      for(i in 2:r) {
        if (a %% i == 0) {
           flag = 0
          break
          }
       }
       if(flag == 1) {
         cat("Prime")
        } else {
          cat("Composite")
        }
    }
  }else{# Empty Input
  cat("Usage: please input a non-negative integer")
}
}else{  # Negative Input
  cat("Usage: please input a non-negative integer")
}
}else{    # Empty Input
  cat("Usage: please input a non-negative integer")
}
