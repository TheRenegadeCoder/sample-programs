import 'dart:async';

void main(List<String> args) async {

  List<int> userInput = args[0].split(",").map((str) => int.tryParse(str))
    .takeWhile((test) => test != null)
    .toList();
    
  List<int> sorted = await sleepsort(userInput);

  print(sorted);
}

Future<List<int>> sleepsort(Iterable<int> input) async {
  List<int> sorted = List();
  await Future.wait(input.map((i) => Future.delayed(Duration(seconds: i), () => sorted.add(i))));
  return Future.value(sorted);
}
