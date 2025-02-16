object SleepSort {
    def main(args: Array[String]): Unit = {
        // test()
        var tArgs: Array[String] = Array("1 2")
      
        println(invalidChecker(tArgs))
    }
    
    def invalidChecker(args: Array[String]): Unit = {
      if(args == null || args.isEmpty){
        println("No Input")
      }else if(args.length == 0){
        println("Empty Input")
      }else if(args.length == 1){
        println("Invalid Input: Not A List")
      }else if(!args.contains(",")){
        println("Invalid Input: Wrong Format")
      }
    }
}