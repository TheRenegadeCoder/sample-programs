//Issue 4972

void main(List<String> argv){
  const String error_message = "Usage: please provide a string";
  if (argv.isEmpty || argv[0].isEmpty){
    print(error_message);
    return;
  }

  String sentence = argv[0];
  String raw = sentence.replaceAll(r'\t', '\t').replaceAll(r'\r', '\r').replaceAll(r'\n', '\n');
  List<String> words = raw.split(RegExp(r'\s+'));
  int max_length= 0;

  for (String each_word in words){
    if (each_word.length > max_length){
      max_length = each_word.length;
    }
  }
  print(max_length);
}
