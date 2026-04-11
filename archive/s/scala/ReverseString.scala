object ReverseString:
  @main def run(args: String*): Unit =
    args.headOption.map(_.reverse).foreach(println)