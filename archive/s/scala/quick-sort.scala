import scala.io.StdIn.readLine
import scala.reflect.ClassTag

object QuickSortSamples {
  def main(args: Array[String]) {
    // example of sorting integers
    val inputInts = readLine().split(" ").map(_.toInt)
    val sortedInts = quicksort(inputInts)
    sortedInts.map(println)

    // example of sorting words (Strings)
    val inputWords = readLine().split(" ")
    val sortedWords = quicksort(inputWords)
    sortedWords.map(println)

    // example of sorting using custom Ordering
    object longerString extends Ordering[String] {
      def compare(lhs: String, rhs: String): Int = lhs.length - rhs.length
    }

    val sortedWordsByLength = qsCustom(inputWords)(longerString)
    sortedWordsByLength.map(println)
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

  // in case we want to sort using custom comparator,
  // we implement sort that accepts an Ordering object to match scala.util.Sorting.quicksort signature
  // Ordering[T] object implement compare(a: T, b: T), returning integers
  // this helps comparing more complicated structures, with a custom-defined Ordering
  def qsCustom[T: ClassTag](arr: Array[T])(order: Ordering[T]): Array[T] = arr.length match {
    case 0 => arr
    case 1 => arr
    case _ => {
      val pivot: T = arr(0)
      val lhs = arr.filter(order.compare(_, pivot) < 0)
      val mid = arr.filter(order.compare(_, pivot) == 0)
      val rhs = arr.filter(order.compare(_, pivot) > 0)

      qsCustom(lhs)(order) ++ mid ++ qsCustom(rhs)(order)
    }
  }
}