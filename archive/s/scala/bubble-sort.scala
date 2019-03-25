import scala.io.StdIn.readLine
import scala.reflect.ClassTag

object BubbleSortSample {
  def main(args: Array[String]) {
    // verify inputs are being provided
    parseInput(args) match {
      case None => println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
      case Some(inputArr) => {
        val output = bubbleSort(inputArr).mkString(", ")
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

  // bubble the current element

  // bubble sort increasing elements
  // note on signature:
  // ClassTag elements help construct Array quen using ++ (instead of falling back to ArraySeq)
  // Elements of array implement Ordered, so we can compare 2 instances of T using ==, <, >, etc.
  def bubbleSort[T <% Ordered[T]: ClassTag](arr: Array[T]): Array[T] = {
    def bubble(a: Array[T]): Array[T] = a.length match {
      case 0 => a
      case 1 => a
      case _ => {
        if (a(0) > a(1)) {
          a.slice(1, 2) ++ bubble(a.slice(0, 1) ++ a.slice(2, a.length))
        }
        else {
          a.slice(0, 1) ++ bubble(a.slice(1, a.length))
        }
      }
    }
    arr.foldLeft(arr)((xs: Array[T], cur: T) => bubble(xs))
  }
}
