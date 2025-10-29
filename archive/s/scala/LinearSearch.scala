object LinearSearch {
    def main(args: Array[String]): Unit = {
        if (args.length != 2) {
            println("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
            return
        }
        
        val list = args(0);
        val key = args(1);

        try {
            val arr = list.split(",").map(_.trim.toInt)
            val target = key.trim.toInt
           
            var flag = 0
            var pos = -1
            for (i <- arr.indices) {
                if (arr(i) == target) {
                    flag = 1
                    pos = i
                    println("true")
                    return
                }
            }
