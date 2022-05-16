
private fun lcsOf(a: MutableList<String>, b: MutableList<String>, indexA: Int, indexB: Int): MutableList<String> {
    return if (indexA < 0 || indexB < 0) {
        mutableListOf()
    } else if (a[indexA] == b[indexB]) {
        // get the best subsequence of the rest, then add this one at the end (prevents needing to reverse at the end)
        lcsOf(a, b, indexA - 1, indexB - 1).also { it.add(a[indexA] )}
    } else {
        // compare both subsequences and return the one that has more element
        val subA = lcsOf(a, b, indexA, indexB - 1)
        val subB = lcsOf(a, b, indexA - 1, indexB)
        if (subA.size >= subB.size) subA else subB
    }
}

// only require consumers to pass in the lists... we'll handle the indices ourselves
fun lcsOf(a: List<String>, b: List<String>) = lcsOf(a.toMutableList(), b.toMutableList(), a.size - 1, b.size - 1)

fun main(args: Array<String>) {
    if (args.size != 2 || args[0].isBlank() || args[1].isBlank()) {
        // print and exit if we don't have the correct number of arguments
        println("Usage: please provide two lists in the format \"1, 2, 3, 4, 5\"")
        return
    }

    // split each argument by comma, remove whitespace around each element, and pack them all in a list
    val seqA = args[0].split(",").map { it.trim() }
    val seqB = args[1].split(",").map { it.trim() }

    lcsOf(seqA, seqB).joinToString(", ").also { println(it) }
}
