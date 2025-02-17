import scala.collection.mutable.ListBuffer
import scala.concurrent._
import ExecutionContext.Implicits.global
import scala.concurrent.duration._

object SleepSort {
  def main(args: Array[String]): Unit = {
    // test()
    // val args: Array[String] = Array("9, 8, 7, 6, 5, 4, 3, 2, 1")

    var result = invalidChecker(args)
      
    if(!result.contains("true")){
      println(result)
    }else {
      // println("passes")
      val numbers = args.flatMap(_.split(",")).map(_.trim).filter(_.nonEmpty).map(_.toInt)
      println(sleepSort(numbers))
    }
  }
    
  def invalidChecker(args: Array[String]): String = args match{
    case null | Array() => "No Input"
    case arr if arr.forall(_.isEmpty) =>  "Empty Input"
    case arr if arr.forall(_.length == 1) && arr.length == 1 => "Invalid Input: Not A List"
    case arr if !arr.exists(_.contains(",")) => "Invalid Input: Wrong Format"
      // case _ => "Valid Input" //holder for testing
    case _ => {
      val numbers = args.flatMap(_.split(",")).map(_.trim).filter(_.nonEmpty)
      
      if (numbers.forall(n => n.forall(_.isDigit))) {
        "true"
      } else {
        "Invalid Input: Non-numeric Values"
      }
    }
  }

  def sleepSort(args: Array[Int]): String = {
    val delayTimer: Long = 1000L
    val outputArray = ListBuffer[String]()

    val futures = args.map { num =>
      Future {
        Thread.sleep(num * delayTimer) // Delay execution
        synchronized { // Ensure thread safety
          outputArray += num.toString
        }
      }
    }

    Await.result(Future.sequence(futures), Duration.Inf) // Wait for all futures
    outputArray.mkString(", ")
  }
    
    // def SleepSort(args: Array[Int]): String = {
      // val delayTimer: Long = 5000L
      // var sizeArr: Int = args.length
      // var outputArray = ListBuffer[String]()
      
      // val futures = args.map { num =>
      //   Future {
      //     Thread.sleep(num * 1000L) // Sleep according to value
      //     print(s"$num ") // Print value in order of sleep
      //   }
      // }

      // Await.result(Future.sequence(futures), Duration.Inf)

      // args.foreach{ num =>
      //   val futures: Future = Future {
      //     Thread.sleep(num * delayTimer) // Delay execution
      //     synchronized { // Ensure thread safety
      //       if (num != args.last) {
      //         outputArray += (num.toString + ", ")
      //       } else {
      //         outputArray += num.toString
      //       }
      //     }
      //   }

        // Thread.sleep(num * delayTimer) // Delay execution
        // if (sizeArr != 1) {
        //   outputArray += (num.toString + ", ") // Append with ListBuffer
        // } else {
        //   outputArray += num.toString // Append the last number without a comma
        // }
        // sizeArr -=  1
      // }

    //   Await.result(Future.sequence(futures), Duration.Inf) 
      
    //   outputArray.mkString("")  // Return the concatenated string
    // }
    
  // def timeRecorder(args: Array[Int]): String = {
  //   val startTime = System.nanoTime() // ✅ Record start time before the loop
  
  //   args.foreach { num =>
  //     Thread.sleep(num * 1000L) // Simulating a delay
  //   }
  
  //   val endTime = System.nanoTime() // ✅ Record end time after iteration
  
  //   "Total Execution Time: ${(endTime - startTime) / 1e6} ms" // ✅ Return time in milliseconds
  // }
}