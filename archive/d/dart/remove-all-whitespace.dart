// Issue 4973
void main(List<String> argv){
  const String error_message = "Usage: please provide a string";
  if (argv.isEmpty || argv[0].isEmpty){
    print(error_message);
    return;
  }
  //Convert  \r, ]n and \t explicitly into carriage return, newline and tab

  // Replace carriage return, newline and tab with empty string
  String sentence_no_spaces = argv[0].replaceAll(RegExp(r'[\t\r\n ]'), '');
  print(sentence_no_spaces);
}
