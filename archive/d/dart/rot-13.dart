import 'dart:io';

main(List<String> args) {
  if (args.isEmpty) {
    stdout.write("Enter string to encode/decode: ");
    args = [stdin.readLineSync()];
  }

  args.forEach((arg) {
    print(rot13(arg));
  });
}

String rot13(String input) {
  int aLower = "a".codeUnitAt(0);
  int aUpper = "A".codeUnitAt(0);
  int nLower = "n".codeUnitAt(0);
  int nUpper = "N".codeUnitAt(0);
  int zLower = "z".codeUnitAt(0);
  int zUpper = "Z".codeUnitAt(0);

  List<String> coded = [];
  String codedResult;

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

  if (coded.isNotEmpty) {
    codedResult = coded.join();
  } else {
    print("Usage: please provide a string to encrypt");
    exit(1);
  }

  return codedResult;
}
