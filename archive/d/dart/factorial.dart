// Issue 4969
void main(List<String> args){
  const String error_message = "Usage: please input a non-negative integer";
  try{

    int factorial = 1;
    int num_needed = int.parse(args[0]);
    if (num_needed.isNegative == true){
      print(error_message);
    }
    else{
      for (int i_index = 1; i_index <= num_needed; i_index ++){
        factorial *= i_index;
      }
      print(factorial.toString());
    }

  }
  catch(e){
    print(error_message);
  }
}
