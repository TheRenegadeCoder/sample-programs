//Issue 4974
void main(List<String> args){
  const String error_message = "Usage: please provide a string";
  if (args.isEmpty || args[0].isEmpty){
    print(error_message);
    return;
  } // end of empty check
  
  Map<String, int> frequency = {};
  bool duplicate_not_found = true;

  for (int i = 0; i < args[0].length; i ++){
    String char = args[0][i];
    if (RegExp(r'[a-zA-Z0-9]').hasMatch(char)) {
      frequency[char] = (frequency[char] ?? 0) + 1;
    }
  } // end of checking duplicate characters
  
  //either print all duplicate letters or set flag duplicate letters not found
  frequency.forEach((char, count){
    if (count > 1) {
      duplicate_not_found = false; // at least 1 duplicate letter is found
      print('$char: $count');
    }
  });
  // print if no duplicate characters
  if(duplicate_not_found == true){
      print("No duplicate characters");
  }
}
