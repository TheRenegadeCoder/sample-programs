fun main(args : Array<String>){
    if (args.size != 2) {
        println("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
        return
    }

    val listInput = args[0].replace(",", "")
    val targetInput = args[1]

    val arr: IntArray
    val target: Int

    try {
        arr = listInput.split(" ").map { it.toInt() }.toIntArray()
        target = targetInput.toInt()
    } catch (e: NumberFormatException) {
        println("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
        return
    }

    if (!isSorted(arr)) {
        println("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
        return
    }

    val result = binarySearch(arr, target)
    println(result)
}

fun binarySearch(arr: IntArray, target: Int): Boolean{
    var left = 0;
    var right = arr.size - 1

    while(left <= right){
        var mid = (left + right) / 2;
        if(arr[mid] == target){
            return true
        } else if(arr[mid] < target){
            left = mid + 1
        }else{
            right = mid - 1
        }
    }
        
    return false
}


fun isSorted(arr: IntArray): Boolean {
    for (i in 0 until arr.size - 1) {
        if (arr[i] > arr[i + 1]) {
            return false
        }
    }
    return true
}