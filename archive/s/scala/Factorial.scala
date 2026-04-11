import scala.util.Try

object Factorial:
  private val usage = "Usage: please input a non-negative integer"

  def main(args: Array[String]): Unit =
    val result =
      args.headOption
        .flatMap(a => Try(a.toInt).toOption)
        .filter(_ >= 0)
        .map(factorial)

    result match
      case Some(value) => println(value)
      case None => println(usage)

  private def factorial(n: Int): Int =
    (1 to n).product