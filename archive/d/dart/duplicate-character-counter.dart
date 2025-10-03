//Issue 4974
import 'dart.io';
// fixed the typo LIst to List
void main(List<String> args){
  const String error_message = "Usage: please provide a string";
  if (args.isEmpty || args[0].isEmpty){
    print(error_message);
    return;
  }
  
  Map<String, int> frequency = {};

  for (int i = 0; i < args[0].length; i ++){
    String char = args[0][i];
    if (RegExpr(r'[a-zA-Z0-9]').hasMatch(char)) {
      frequency[char] = (frequency[char] ?? 0) + 1;
    }
  }

  frequency.forEach((char, count){
    if (count > 1) {
      print('$char: $count');
    }
  });
}  
