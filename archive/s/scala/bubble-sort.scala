import scala.io.StdIn.readLine
import scala.reflect.ClassTag

object BubbleSortSamples {
  def main(args: Array[String]) {
    // example of sorting integers
    val inputInts = readLine().split(" ").map(_.toInt)
    val sortedInts = bubblesort(inputInts)
    sortedInts.map(println)

    // example of sorting words (Strings)
    val inputWords = readLine().split(" ")
    val sortedWords = bubblesort(inputWords)
    sortedWords.map(println)

    // example of sorting using custom Ordering
    object longerString extends Ordering[String] {
      def compare(lhs: String, rhs: String): Int = lhs.length - rhs.length
    }

    val sortedWordsByLength = bsCustom(inputWords)(longerString)
    sortedWordsByLength.map(println)
  }

  // bubble the current element

  // bubble sort increasing elements
  // note on signature:
  // ClassTag elements help construct Array quen using ++ (instead of falling back to ArraySeq)
  // Elements of array implement Ordered, so we can compare 2 instances of T using ==, <, >, etc.
  def bubblesort[T <% Ordered[T]: ClassTag](arr: Array[T]): Array[T] = {
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

  // in case we want to sort using custom comparator,
  // we implement sort that accepts an Ordering object to match scala.util.Sorting.bubblesort signature
  // Ordering[T] object implement compare(a: T, b: T), returning integers
  // this helps comparing more complicated structures, with a custom-defined Ordering
  def bsCustom[T: ClassTag](arr: Array[T])(order: Ordering[T]): Array[T] = {
    def bubble(a: Array[T]): Array[T] = a.length match {
      case 0 => a
      case 1 => a
      case _ => {
        if (order.compare(a(0), a(1)) > 0) {
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
