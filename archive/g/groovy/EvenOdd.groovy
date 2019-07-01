class EvenOdd {
  static void main(String... args) {
    if(args?.length != 1 || !args[0]?.isInteger()) {
      println 'Usage: please input a number'
    } else {
      println args[0].toInteger() % 2 == 0 ? 'Even' : 'Odd'
    }
  }
}
