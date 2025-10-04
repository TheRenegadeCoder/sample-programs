import scala.util.{Try, Success, Failure}

object Fibonacci {

  def fibonacci(n: Int) = {
    var a = 0
    var b = 1
    for (i <- 1 to n) {
      println(s"$i: $b")
      val c = a + b
      a = b
      b = c
    }
  }


  def main(args: Array[String]) = {
    Try(args(0).toInt) match {
      case Failure(_) => println("Usage: please input the count of fibonacci numbers to output")
      case Success(n) => fibonacci(n)
    }
  }
}
