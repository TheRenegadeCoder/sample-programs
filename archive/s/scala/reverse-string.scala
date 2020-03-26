import scala.io.StdIn.readLine

object ReverseStringSample {
  // revese using recursive & pattern matching
  def reverseString(str: String): String = str.length match {
    case 0 => ""
    case 1 => str
    case _ => reverseString(tail(str)) ++ head(str)
  }

  def head(str: String): String = str.length match {
    case 0 => ""
    case _ => str.slice(0, 1)
  }

  def tail(str: String): String = str.length match {
    case 0 => ""
    case 1 => ""
    case _ => str.slice(1, str.length)
  }

  def main(args: Array[String]) {
    val inputStr: Option[String] = args.length match {
      case 0 => None
      case _ => Some(args(0))
    }
    inputStr.map(reverseString).map(println)
  }
}
