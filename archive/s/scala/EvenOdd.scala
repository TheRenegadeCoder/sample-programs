import scala.util.Try

object EvenOdd:
  private val usage = "Usage: please input a number"

  def main(args: Array[String]): Unit =
    val result =
      args.headOption
        .flatMap(a => Try(a.toInt).toOption)
        .map(n => if n % 2 == 0 then "Even" else "Odd")
        .getOrElse(usage)

    println(result)