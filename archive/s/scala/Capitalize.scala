object Capitalize {
  def main(args: Array[String]) {
    val inputStr: Option[String] = args.length match {
      case 0 => Some("")
      case _ => Some(args(0))
    }
    if (inputStr.get.length < 1) {
      println("Usage: please provide a string")
    }
    else {
      inputStr.map(_.capitalize).map(println)
    }
  }
}
