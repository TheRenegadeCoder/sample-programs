import java.util.concurrent.ConcurrentLinkedQueue
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration.*
import scala.concurrent.{Await, Future}
import scala.jdk.CollectionConverters.*
import scala.util.Try

object SleepSort:
  private val TimeUnit = 100.milliseconds
  private val Buffer = 500.milliseconds

  private val usage =
    """Usage: please provide a list of at least two integers in the format "1, 2, 3, 4, 5""""

  def main(args: Array[String]): Unit =
    val result =
      args.headOption
        .flatMap(parse)
        .filter(_.length >= 2)
        .map(sort)
        .map(_.mkString(", "))
        .getOrElse(usage)

    println(result)

  private def parse(input: String): Option[List[Int]] =
    Try(input.split(',').map(_.trim.toInt.max(0)).toList).toOption

  private def sort(xs: List[Int]): List[Int] =
    val collector = new ConcurrentLinkedQueue[Int]()

    val tasks = xs.map { n =>
      Future {
        Thread.sleep((n * TimeUnit).toMillis)
        collector.add(n)
      }
    }

    // The buffer is there to ensure that all tasks have finished
    val maxWait = (xs.maxOption.getOrElse(0) * TimeUnit) + Buffer
    val allDone = Future.sequence(tasks)
    Await.result(allDone, maxWait)

    collector.asScala.toList