import kotlin.system.exitProcess

// First arg is number of iterations to run
fun main(args: Array<String>) {
    if (args.size != 1)
        exitProcess(1)
    val iterations = args[0].toIntOrNull() ?: exitProcess(1)

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