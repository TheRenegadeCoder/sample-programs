//Issue 4971
void main(List<String> args){
  const String error_message= "Usage: please input a non-negative integer";
  if (args.isEmpty){
    print(error_message);
    return;
  }

  try{
    bool is_palindrome = true;
    int num_needed = int.parse(args[0]);

    if (num_needed.isNegative){
      print(error_message);
      return;
    }
 
   String original_string = num_needed.toString();
   String reverse_string = original_string.split('').reversed.join('') ;
   is_palindrome = (original_string == reverse_string);

    print(is_palindrome);
  }
  catch(e){
    print(error_message);
  }
}
