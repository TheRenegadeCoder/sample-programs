// Issue 4973
void main(List<String> argv){
  const String error_message = "Usage: please provide a string";
  if (argv.isEmpty || argv.isEmpty){
    print(error_message);
    return;
  }
  //Convert  \r, ]n and \t explicitly into carriage return, newline and tab
  String raw = argv[0].replaceAll(r'\t', '\t').replaceAll(r'\r', '\r').replaceAll(r'\n', '\n');
  // Replace carriage return, newline and tab with empty string
  String sentence_no_spaces = raw.replaceAll(RegExp(r'[\t\r\n ]'), '');
  print(sentence_no_spaces);
}
