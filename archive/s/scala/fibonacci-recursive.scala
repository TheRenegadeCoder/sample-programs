import javax.xml.bind.ValidationException

object TestClass {

  def fibonacci_rec(n: Int): Int = {
    if (n < 0) {
      // If invalid input throw an exception
      throw new ValidationException("Index should be positive")

    } else if (n == 1 || n == 2) {
      // Recursion anchors

      return 1

    } else {
      // Definition of Fibonacci sequence (sum of two previous numbers in the sequence)

      return fibonacci_rec(n - 1) + fibonacci_rec(n - 2)
    }

  }


  def main(args: Array[String]): Unit = {
    // Takes input from user and outputs corresponding fibonacci number
    println("Please enter an index: ")
    val index = scala.io.StdIn.readInt()
    println(fibonacci_rec(index))
  }
}
