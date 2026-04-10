import java.util.concurrent.{CountDownLatch, Executors}
import java.util.{ArrayList, Collections}
import scala.util.Try
import scala.jdk.CollectionConverters._

object SleepSort {
  def main(args: Array[String]): Unit =
    args.toList match {
      case raw :: Nil =>
        val numbers = parse(raw)

        if (numbers.length < 2)
          usage()

        println(format(sleepSort(numbers)))

      case _ =>
        usage()
    }

  private def usage(): Nothing = {
    println("""Usage: please provide a list of at least two integers in the format "1, 2, 3, 4, 5"""")
    sys.exit(1)
  }

  private def parse(input: String): List[Int] =
    input
      .split(",")
      .iterator
      .map(_.trim)
      .filter(_.nonEmpty)
      .flatMap(s => Try(s.toInt).toOption)
      .toList
    match {
      case Nil => usage()
      case xs => xs
    }

  private def format(xs: List[Int]): String =
    xs.mkString(", ")

  private def sleepSort(input: List[Int]): List[Int] = {
    val sortedList = Collections.synchronizedList(new ArrayList[Int]())
    val executor = Executors.newCachedThreadPool()
    val latch = new CountDownLatch(input.size)

    input.foreach { n =>
      executor.submit(new Runnable {
        override def run(): Unit = {
          try {
            Thread.sleep(n.toLong * 100L)
            sortedList.add(n)
          } catch {
            case _: InterruptedException =>
              Thread.currentThread().interrupt()
          } finally {
            latch.countDown()
          }
        }
      })
    }

    latch.await()
    executor.shutdown()

    sortedList.asScala.toList
  }
}