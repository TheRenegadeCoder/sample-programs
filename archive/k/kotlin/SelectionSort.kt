import kotlin.system.exitProcess

fun main(args: Array<String>) {
    val nums: IntArray = errorChecking(args)
    selectionSort(nums)
    outputList(nums)
}

fun usageError() {
    println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
}

fun errorChecking(args: Array<String>): IntArray {
    val nums: IntArray
    try {
        nums = args[0].split(", ").map { it.toInt() }.toIntArray()
    } catch (e: Exception) {
        usageError()
        exitProcess(1)
    }
    if (nums.size < 2) {
       usageError()
       exitProcess(1)
    }
    return nums
}

fun selectionSort(nums: IntArray) {
    for (i in 0 until nums.count() - 1) {
        
        var smallestIndex: Int = i
        for (j in i + 1 until nums.count()) {
            if (nums[j] < nums[smallestIndex]) {
                smallestIndex = j
            }
        }

        var swap: Int = nums[i]
        nums[i] = nums[smallestIndex]
        nums[smallestIndex] = swap
    }
}

fun outputList(nums: IntArray) {
    for (i in nums.indices) {
        if (i == nums.count() - 1) {
            println("${nums[i]}")
            return
        }
        print("${nums[i]}, ")
    }
}
