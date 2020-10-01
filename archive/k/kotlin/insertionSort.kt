fun main(args: Array<String>) 
{
    var arr: IntArray
    try
    {
        arr = readLine()!!.split(", ").map{ it.toInt() }.toIntArray()
    }
    catch(e: Exception)
    {
        println("Usage: please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”")
        return
    }

    var ans:IntArray = insertionSort(arr)
    for(i in 0 until ans.count())
    {
        if (i==ans.count()-1)
        {
            println("${ans[i]}")
            return
        }
        print("${ans[i]}, ")
    }
}

fun insertionSort(arr: IntArray):IntArray
{
    for(i in 0 until arr.count())
    {
        for(j in i downTo 1)
        {
            if(arr[j]<arr[j-1])
            {
                //swap
                arr[j] = arr[j-1].also {arr[j-1] =  arr[j]}
            }
            else
            {
                break
            }
        }
    }
    return(arr)
}
