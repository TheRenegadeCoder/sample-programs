import scala.util.Try

object QuickSort:
  private def usage =
    """Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5""""

  @main def run(input: String): Unit =
    val result = for
      nums <- parse(input) if nums.length >= 2
    yield
      sort(nums).mkString(", ")

    println(result.getOrElse(usage))

  private def sort(xs: List[Int]): List[Int] = xs match
    case Nil => Nil
    case pivot :: tail =>
      val (less, more) = tail.partition(_ < pivot)
      sort(less) ++ (pivot :: sort(more))

  private def parse(input: String): Option[List[Int]] =
    Try(input.split(',').iterator.map(_.trim.toInt).toList).toOption