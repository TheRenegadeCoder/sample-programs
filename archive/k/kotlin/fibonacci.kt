import kotlin.system.exitProcess

// First arg is number of iterations to run
fun main(args: Array<String>) {
    if (args.size != 1 && args[0].toIntOrNull() == null)
        exitProcess(1)

    val iterations = args[0].toInt()

    var j: Int
    var k = 0
    var l = 1

    for (i in 1..iterations) {

        print(l)

        if (i != iterations) {
            print(", ")
            j = k
            k = l
            l = j + k
        }
    }
}