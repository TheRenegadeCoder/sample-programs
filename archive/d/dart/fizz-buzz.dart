void fizzBuzz(int maxNumber){
  for(int i=1;i<=maxNumber;i++){
    String output = "";
    if(i%3 == 0){
      output += "Fizz";
    }
    if(i%5 == 0){
      output += "Buzz";
    }
    if(output == ""){
      output = "$i";
    }
    print(output);
  }
}

void main() {
  fizzBuzz(100);
}
