object Baklava:
  private def generate(size: Int): Seq[String] =
    for i <- -size to size yield
      val spaces = i.abs
      val stars = (size * 2 + 1) - 2 * spaces
      " " * spaces + "*" * stars

  @main def run(size: Int = 10): Unit =
    generate(size).foreach(println)