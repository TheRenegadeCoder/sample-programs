import 'dart:async';

void main(List<String> args) async {
  
  if (args.length == 0 || args[0].isEmpty || args[0].split(",").length == 1) {
    print('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
  } else {
    List<int> userInput = args[0].split(",").map((str) => int.tryParse(str))
      .takeWhile((test) => test != null)
      .toList();

    List<int> sorted = await sleepsort(userInput);

    print(sorted);
  }
}

Future<List<int>> sleepsort(Iterable<int> input) async {
  List<int> sorted = List();
  await Future.wait(input.map((i) => Future.delayed(Duration(seconds: i), () => sorted.add(i))));
  return Future.value(sorted);
}
