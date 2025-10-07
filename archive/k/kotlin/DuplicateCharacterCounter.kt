import kotlin.system.exitProcess

fun main(args: Array<String>) {
    val phrase: String = errorChecking(args)
    val counts = duplicateCharacterCount(phrase)
    outputMap(counts)
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

fun duplicateCharacterCount(phrase: String): Map<Char, Int> {
    val counts: Map<Char, Int> = phrase.groupingBy { it }.eachCount()
    return counts.filter { it.value > 1 }
}

fun outputMap(counts: Map<Char, Int>) {
    if (counts.size > 0) {
        for (pair in counts) {
            println("${pair.key}: ${pair.value}")
        }
    } else {
        println("No duplicate characters")
    }
}
