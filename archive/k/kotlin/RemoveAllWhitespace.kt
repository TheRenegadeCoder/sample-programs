import kotlin.system.exitProcess

fun main(args: Array<String>) {
    val phrase: String = errorChecking(args)
    println(removeWhitespace(phrase))
}

fun usageError() {
    println("Usage: please provide a string")
}

fun errorChecking(args: Array<String>): String {
    if (args.size == 0 || args[0] == "") {
       usageError()
       exitProcess(1)
    }
    return args[0]
}

fun removeWhitespace(phrase: String): String {
    return phrase.filter { !it.isWhitespace() }
}
