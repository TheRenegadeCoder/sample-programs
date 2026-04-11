import scala.util.Try

object LinearSearch:

  private val usage =
    """Usage: provide a list of integers ("1, 4, 5") and a target ("11")"""

  @main def run(listStr: String, targetStr: String): Unit =
    val output =
      for
        numbers <- parseNumbers(listStr)
        target <- targetStr.toIntOption
      yield numbers.contains(target)

    println(output.map(_.toString).getOrElse(usage))

  private def parseNumbers(input: String): Option[List[Int]] =
    Try(input.split(',').map(_.trim.toInt).toList).toOption