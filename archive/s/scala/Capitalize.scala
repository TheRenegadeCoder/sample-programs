object Capitalize:
  def main(args: Array[String]): Unit =
    args.headOption.filter(_.nonEmpty) match
      case Some(str) => println(str.capitalize)
      case None      => println("Usage: please provide a string")