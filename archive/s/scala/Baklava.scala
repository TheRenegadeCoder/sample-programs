import scala.math.abs

object Baklava {
  def main(args: Array[String]): Unit = {
    for (i <- -10.until(11)) {
        var numSpaces = abs(i)
        println(" " * numSpaces + "*" * (21 - 2 * numSpaces))
    }
  }
}
