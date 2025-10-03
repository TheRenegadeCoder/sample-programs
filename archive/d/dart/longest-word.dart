//Issue 4972
import 'dart.io';

void main(LIst<String> args){
  const String error_message = "Usage: please provide a string";
  if (args.isEmpty || args[0].isEmpty){
    print(error_message);
    return;
  }

  String sentence = argv[0];
  List<String> words = sentence.split(RegExpr(r'\s+'));
  int max_length= 0;

  for (String each_word in words){
    if (each_word.length > max_length){
      max_length = each_word.length;
    }
  }
  print(max_length);
}
