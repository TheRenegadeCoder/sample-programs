import scala.util.Try

object QuickSort:

  def main(args: Array[String]): Unit =
    val input = args.headOption.getOrElse("")

    parse(input) match
      case Some(nums) if nums.length >= 2 =>
        println(sort(nums).mkString(", "))
      case _ =>
        println(usage)

  def usage: String =
    """Usage: provide at least two integers like: 1, 2, 3"""

  def sort(xs: List[Int]): List[Int] =
    xs match
      case Nil => Nil
      case pivot :: tail =>
        val (less, more) = tail.partition(_ < pivot)
        sort(less) ++ (pivot :: sort(more))

  def parse(input: String): Option[List[Int]] =
    Try(input.split(',').toList.map(_.trim.toInt)).toOption