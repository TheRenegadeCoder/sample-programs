void main(List<String> args) {
  try {
    var n = int.parse(args[0]);
    if (n < 0) {
      throw Exception('Usage: please input a non-negative integer');
    } else if (n >= 996) {
      throw Exception('$n! is out of the reasonable bounds for calculation');
    }
    print(factorial(n));
  } catch (e) {
    print("Usage: please input a number");
  }
}

int factorial(n) {
  if (n <= 0) return 1;
  return n * factorial(n - 1);
}
