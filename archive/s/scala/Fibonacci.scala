object Fibonacci:

  private val fibs: LazyList[BigInt] =
    BigInt(1) #:: BigInt(1) #:: fibs.zip(fibs.tail).map(_ + _)
    
  private val usage =
    "Usage: please input the count of fibonacci numbers to output"

  @main def run(args: String*): Unit =
    val output =
      for
        arg <- args.headOption
        n <- arg.toIntOption if n > 0
      yield
        fibs
          .take(n)
          .zipWithIndex
          .map((f, i) => s"${i + 1}: $f")
          .mkString("\n")

    println(output.getOrElse(usage))