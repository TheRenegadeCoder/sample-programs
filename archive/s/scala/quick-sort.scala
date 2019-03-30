import scala.io.StdIn.readLine
import scala.reflect.ClassTag

object QuickSortSample {
  def main(args: Array[String]) {
    // verify inputs are being provided
    parseInput(args) match {
      case None => println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
      case Some(inputArr) => {
        val output = quicksort(inputArr).mkString(", ")
        println(output)
      }
    }
  }

  def parseInput(args: Array[String]): Option[Array[Int]] = args.length match {
    case 0 => None
    case _ => try {
      Some(args(0).split(",").map(_.trim).map(_.toInt))
    } catch {
      case e: Throwable => None
    }
  }

  // quick sort increasing elements
  // note on signature:
  // ClassTag elements help construct Array quen using ++ (instead of falling back to ArraySeq)
  // Elements of array implement Ordered, so we can compare 2 instances of T using ==, <, >, etc.
  def quicksort[T <% Ordered[T]: ClassTag](arr: Array[T]): Array[T] = arr.length match {
    case 0 => arr
    case 1 => arr
    case _ => {
      val pivot: T = arr(0)
      val lhs = arr.filter(_ < pivot)
      val mid = arr.filter(_ == pivot)
      val rhs = arr.filter(_ > pivot)

      quicksort(lhs) ++ mid ++ quicksort(rhs)
    }
  }
}