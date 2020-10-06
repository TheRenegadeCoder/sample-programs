fun main(args: Array<String>) {
    val jobs = buildJobs(args)
    if (jobs.isNullOrEmpty()) {
        println("Usage: please provide a list of profits and a list of deadlines")
    } else {
        println(maxProfit(jobs.sortedByDescending { it.profit }))
    }
}

private fun maxProfit(sortedJobs: List<Job>): Int {
    val scheduled = hashSetOf<Int>()
    var profit = 0
    sortedJobs.forEach {
        for (i in it.deadline downTo 1) {
            if (scheduled.add(i)) {
                profit += it.profit
                break
            }
        }
    }
    return profit
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
