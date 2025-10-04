import kotlin.system.exitProcess

// First arg is number of iterations to run
fun main(args: Array<String>) {
    if (args.isNullOrEmpty() || args[0].toIntOrNull()?.takeIf { it >= 0 } == null) {
        println("Usage: please input the count of fibonacci numbers to output")
        return
    }

    val iterations = args[0].toInt()

    var j: Int
    var k = 0
    var l = 1

    for (i in 1..iterations) {
        println("$i: $l")

        j = k
        k = l
        l = j + k
    }
}