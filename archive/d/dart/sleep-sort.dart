import 'dart:async';

// massivly overcomplicated sleep sort to demonstrate Completer and Future mechanisms of Dart
void main(List<String> args) async {
  // print "subscribes" to `execFutures" and awaits for returned value from `Completer.future` which will contain
  // a sorted array 
    print(await execFutures(
      sleepSort(
        List.unmodifiable([1, 2, 3, 7])
      )));
}

// builds a list of futues, where each of them sleeps for `e` number of seconds and then returns `e` as int value
List<Future<int>> sleepSort(List<int> elements) {
  List<Future<int>> futures = List();
  elements.forEach((e) {
    futures.add(Future.delayed(Duration(seconds: e), () => e));
  });
  return futures;
}

// Accepts list of Futures as input
// builds a type-safe completer which holds results of all futures and allows
// to pass the values to another blocking method
Future<List<int>> execFutures(List<Future<int>> futures) async {
  Completer<List<int>> c = Completer();
  Future.wait(futures)
  // when is a subscriber for value of completed futures
  // as I called Future.await
  // this will wait for all futures to complete before returning sorted values
  .then((f) {
    c.complete(f);
  });

  return c.future;
}