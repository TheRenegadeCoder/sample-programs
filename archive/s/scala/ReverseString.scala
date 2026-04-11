object ReverseString:
  def main(args: Array[String]): Unit =
    args.headOption match
      case Some(str) => println(str.reverse)
      case None      => println("")