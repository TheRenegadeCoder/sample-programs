void main(List<String> args) async {
    await execFutures(
      sleepSort(List.unmodifiable([1, 2, 3])
      )).then((r) => print(r));
}

List<Future<int>> sleepSort(List<int> elements) {
  List<Future<int>> futures = List();
  elements.forEach((e) {
    futures.add(Future.delayed(Duration(seconds: e)));
  });
  return futures;
}

Future<List<int>> execFutures(List<Future<int>> futures) {
  List<int> results = List();
  futures.forEach((f) {
  f.then((result) {
      results.add(result);
    });
  });
  return results;
}