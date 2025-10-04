// Issue 4970
import 'dart:math';

void main(List<String> args){
  const String error_message= "Usage: please input a non-negative integer";
  if (args.isEmpty){
    print(error_message);
    return;
  }

  try{
    bool is_prime = true;
    int num_needed = int.parse(args[0]);

    if (num_needed.isNegative){
      print(error_message);
      return;
    }

    // If the number is even number other than 2 OR if the number is multiple of 5 other than 5 or if number is either 0 or 1, Print Composite
    if( (num_needed == 0)|| (num_needed == 1) || (num_needed %2 ==0 && num_needed != 2) || (num_needed %5  ==0 && num_needed != 5) ){
      print("Composite");
      return;
    }

    for (int i_index = 3; i_index <= sqrt(num_needed).toInt(); i_index +=2){
      if(num_needed % i_index == 0){
        is_prime = false;
        break;
      }
    }

    print(is_prime ? "Prime" : "Composite");
  }
  catch(e){
    print(error_message);
  }
}
