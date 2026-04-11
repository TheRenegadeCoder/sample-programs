object Capitalize:

  @main def run(args: String*): Unit =
    args.headOption.filter(_.nonEmpty) match
      case Some(str) => println(str.capitalize)
      case None      => println("Usage: please provide a string")