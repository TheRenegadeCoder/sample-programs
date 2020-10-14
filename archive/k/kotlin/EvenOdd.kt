fun main(args: Array<String>) {
    if (args.isNullOrEmpty() || args[0].toIntOrNull() == null) {
        println("Usage: please input a number")
        return
    }
    val num = args[0].toInt()
    if (num % 2 == 0) {
        println("Even")
    } else {
        println("Odd")
    }
}