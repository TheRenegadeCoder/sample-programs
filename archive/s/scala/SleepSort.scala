object SleepSort {
    def main(args: Array[String]): Unit = {
      // test()
      var tArgs: Array[String] = Array("4 5 3")

      println(invalidChecker(tArgs))
    }
    
    def invalidChecker(args: Array[String]): String = args match{
      case null | Array() => "No Input"
      case arr if arr.forall(_.isEmpty) =>  "Empty Input"
      case arr if arr.forall(_.length == 1) => "Invalid Input: Not A List"
      case arr if !arr.exists(_.contains(",")) => "Invalid Input: Wrong Format"
      case _ => "Valid Input" //holder for testing
    }
}