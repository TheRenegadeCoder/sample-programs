import scala.collection.mutable.ListBuffer
import scala.concurrent._
import ExecutionContext.Implicits.global
import scala.concurrent.duration._

object SleepSort {
  def main(args: Array[String]): Unit = {
    var result = invalidChecker(args)
      
    if(!result){ // After going through checker, it will output result to procede with SleepSort or not
      // println(result)
      println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
    } else {
      val numbers = args.flatMap(_.split(",")).map(_.trim).filter(_.nonEmpty).map(_.toInt)
      println(sleepSort(numbers))
    }
  }
    

  // Checking for formating, empty array, and Non-numeric values
  def invalidChecker(args: Array[String]): Boolean = args match {
    case null | Array() => false  // "No Input"
    case arr if arr.forall(_.isEmpty) =>  false //"Empty Input"
    case arr if arr.forall(_.length == 1) && arr.length == 1 => false //"Invalid Input: Not A List"
    case arr if !arr.exists(_.contains(",")) => false //"Invalid Input: Wrong Format"
    case _ =>  true
    // case _ => {
    //   val numbers = args.flatMap(_.split(",")).map(_.trim).filter(_.nonEmpty)
      
    //   if (numbers.forall(n => n.forall(_.isDigit))) {
    //     true  //"true" // <- passing true to procede with SleepSort
    //   } else {
    //     false //"Invalid Input: Non-numeric Values"
    //   }
    // }
  }

  // delaying time to add a value to list base on it weight
  def sleepSort(args: Array[Int]): String = {
    val delayTimer: Long = 100L
    val output = new ListBuffer[Int]()

    val futures = args.map { num =>
      Future {
        Thread.sleep(num * delayTimer) // Delay execution
        this.synchronized { // Ensure thread safety
          output += num
        }
      }
    }.toList // Convert Array to List to fix type mismatch

    Await.result(Future.sequence(futures), Duration.Inf) // Wait for all futures
    output.mkString(", ") // Format output correctly
  }
}
