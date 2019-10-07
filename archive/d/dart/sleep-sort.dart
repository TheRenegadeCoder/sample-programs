import 'dart:async';

// massivly overcomplicated sleep sort to demonstrate Completer and Future mechanisms of Dart
void main(List<String> args) async {
    print(await execFutures(
      sleepSort(
        List.unmodifiable([1, 2, 3, 7])
      )));
}

List<Future<int>> sleepSort(List<int> elements) {
  List<Future<int>> futures = List();
  elements.forEach((e) {
    futures.add(Future.delayed(Duration(seconds: e), () => e));
  });
  return futures;
}

Future<List<int>> execFutures(List<Future<int>> futures) async {
  Completer<List<int>> c = Completer();
  Future.wait(futures).then((f) {
    c.complete(f);
  });

  return c.future;
}