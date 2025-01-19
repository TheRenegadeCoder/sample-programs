for (i in (1..100)) {
  if (i % 15 == 0) {
    System.print("FizzBuzz")
  } else if (i % 5 == 0) {
    System.print("Buzz")
  } else if (i % 3 == 0) {
    System.print("Fizz")
  } else {
    System.print(i)
  }
}
