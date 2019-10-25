import 'dart:io';

main(List<String> args) {
  if (args.isEmpty || args[0].isEmpty) {
    print("Usage: please provide a string to encrypt");
    exit(1);
  } else {
    print( rot13(args[0]) );
  }
}

String rot13(String input) {
  int aLower = "a".codeUnitAt(0);
  int aUpper = "A".codeUnitAt(0);
  int nLower = "n".codeUnitAt(0);
  int nUpper = "N".codeUnitAt(0);
  int zLower = "z".codeUnitAt(0);
  int zUpper = "Z".codeUnitAt(0);

  List<String> coded = [];

  input.codeUnits.forEach((char) {
    if ((char >= aLower && char < nLower) ||
        (char >= aUpper && char < nUpper)) {
      coded.add(new String.fromCharCode(char + 13));
    } else if ((char >= nLower && char <= zLower) ||
        (char >= nUpper && char <= zUpper)) {
      coded.add(new String.fromCharCode(char - 13));
    } else {
      coded.add(new String.fromCharCode(char));
    }
  });

  return coded.join();
}
