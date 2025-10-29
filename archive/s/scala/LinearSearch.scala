object LinearSearch {
    def main(args: Array[String]): Unit = {
        if (args.length != 2) {
            println("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
            return
        }
