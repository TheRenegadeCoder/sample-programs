import kotlin.system.exitProcess

fun main(args: Array<String>) {
    val nums: IntArray = errorChecking(args)
    insertionSort(nums)
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

fun insertionSort(nums: IntArray) {
    for (i in 1 until nums.count()) {
        val toMove: Int = nums[i]
        var j: Int = i - 1
        
        while (j >= 0 && nums[j] > toMove) {
            nums[j + 1] = nums[j]
            j = j - 1
        }
        
        nums[j + 1] = toMove
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
