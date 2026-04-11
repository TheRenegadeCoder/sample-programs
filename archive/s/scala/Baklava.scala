object Baklava:
  def generate(size: Int): Seq[String] =
    for i <- -size to size yield
      val spaces = i.abs
      val stars = (size * 2 + 1) - 2 * spaces
      " " * spaces + "*" * stars

  def main(args: Array[String]): Unit =
    val size =
      if args.nonEmpty then args(0).toInt
      else 10

    generate(size).foreach(println)