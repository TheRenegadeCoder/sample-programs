import scala.util.Try

object LinearSearch:

  private val usage =
    """Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")"""

  def main(args: Array[String]): Unit =
    if args.length < 2 then
      println(usage)
    else
      val listStr = args(0)
      val targetStr = args(1)

      val output =
        for
          numbers <- parseNumbers(listStr)
          target   <- targetStr.toIntOption
        yield numbers.contains(target)

      println(output.map(_.toString).getOrElse(usage))

  private def parseNumbers(input: String): Option[List[Int]] =
    Try(input.split(',').map(_.trim.toInt).toList).toOption