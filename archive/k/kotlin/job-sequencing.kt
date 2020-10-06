fun main(args: Array<String>) {
    args.forEach { println(it) }
    var jobs = buildJobs(args)
    if (jobs.isNullOrEmpty()) {
        println("Usage: please provide a list of profits and a list of deadlines")
    } else {
        jobs.forEach { println("(${it.profit}, ${it.deadline})") }
        jobs = jobs.sortedByDescending { it.profit }
        jobs.forEach { println("(${it.profit}, ${it.deadline})") }
    }
}

private fun buildJobs(args: Array<String>): List<Job>? {
    if (args.isNullOrEmpty() || args.size < 2 || args.any { it.isBlank() }) return null

    val profits = args[0].toIntArray()
    val deadlines = args[1].toIntArray()

    if (profits.size != deadlines.size) return null
    return profits.mapIndexed { index, profit -> Job(profit, deadlines[index]) }
}

class Job(val profit: Int, val deadline: Int)

fun String.toIntArray() = split(",").mapNotNull { it.trim().toIntOrNull() }
