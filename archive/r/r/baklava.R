# Top part of Baklava
for(i in 0:9){
  spaces = 10 - i
  stars = i*2 + 1
  for(j in 0:spaces){
    cat(" ")
  }
  for (j in 1:stars){
    cat("*")
  }
  cat("\n")
}
# Bottom part of Baklava
for(i in 10:0){
  spaces = 10 - i
  stars = i*2 + 1
  for(j in 0:spaces){
    cat(" ")
  }
  for (j in 1:stars){
    cat("*")
  }
  cat("\n")
}
