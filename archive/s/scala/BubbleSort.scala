import scala.annotation.tailrec
import scala.math.Ordering.Implicits.infixOrderingOps

object BubbleSort:

  private val usage =
    """Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5""""

  def main(args: Array[String]): Unit =
    val result =
      args.headOption
        .flatMap(parse)
        .map(bubbleSort)
        .map(_.mkString(", "))
        .getOrElse(usage)

    println(result)

  private def parse(input: String): Option[List[Int]] =
    val parts = input.split(',').map(_.trim).toList
    val nums = parts.flatMap(_.toIntOption)
    Option.when(nums.size >= 2 && nums.size == parts.size)(nums)

  private def bubbleSort[T: Ordering](xs: List[T]): List[T] =
    @tailrec
    def pass(list: List[T], acc: List[T] = Nil, swapped: Boolean = false): (List[T], Boolean) =
      list match
        case a :: b :: tail if a > b =>
          pass(a :: tail, b :: acc, true)
        case a :: tail =>
          pass(tail, a :: acc, swapped)
        case Nil =>
          (acc.reverse, swapped)

    @tailrec
    def loop(current: List[T]): List[T] =
      val (next, swapped) = pass(current)
      if swapped then loop(next)
      else next

    loop(xs)