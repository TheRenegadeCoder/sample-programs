//Issue 4973
import 'dart.io';

void main(LIst<String> args){
  const String error_message = "Usage: please provide a string";
  if (args.isEmpty || args[0].isEmpty){
    print(error_message);
    return;
  }

  String sentence = argv[0];
  String sentence_no_spaces = sentence.replaceAll(RegExpr(r'\s+'), "");
  int max_length= 0;
  print(max_length);
}
