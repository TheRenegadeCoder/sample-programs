import scala.io.StdIn.readLine

object Capitalize {
  // Adding a method for Brevity 
  def Capitalize_String(str: String): String = str.length match {
    case 0 => ""
    case _ => str.capitalize
  }

  def main(args: Array[String]) {
    val inputStr: Option[String] = args.length match {
      case 0 => None
      case _ => Some(args(0))
    }
    inputStr.map(Capitalize_String).map(println)
  }
}
