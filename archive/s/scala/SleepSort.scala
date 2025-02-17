object SleepSort {
    def main(args: Array[String]): Unit = {
      // test()
      var tArgs: Array[String] = Array("4 5 3")

      println(invalidChecker(tArgs))
    }
    
    def invalidChecker(args: Array[String]): String = args match{
      case null | Array() => "No Input"
      case arr if arr.forall(_.isEmpty) =>  "Empty Input"
      case arr if arr.forall(_.length == 1) && arr.length == 1 => "Invalid Input: Not A List"
      case arr if !arr.exists(_.contains(",")) => "Invalid Input: Wrong Format"
      case _ => {
        val numbers = args.flatMap(_.split(",")).map(_.trim).filter(_.nonEmpty)
        
          if (numbers.forall(n => n.forall(_.isDigit))) {
            // timeRecorder(numbers.map(_.toInt))
          } else {
            "Invalid Input: Non-numeric Values"
          }
      }
    }
}