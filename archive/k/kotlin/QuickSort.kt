fun main(args: Array<String>) 
{
    var arr: IntArray
    try
    {
        arr = args[0].split(", ").map{ it.toInt() }.toIntArray()
        if (arr.size < 2) {
            throw Exception()
        }
    }
    catch(e: Exception)
    {
        println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
        return
    }

    var ans:IntArray = quickSort(arr)
    for(i in 0 until ans.count())
    {
        if (i==ans.count() - 1)
        {
            println("${ans[i]}")
            return
        }
        print("${ans[i]}, ")
    }
}

fun quickSort(arr: IntArray):IntArray
{
    if (arr.count() == 1)
    {
        return(arr.sliceArray(0..0))
    }
    var pivot:Int = (arr.count() - 1) / 2 
    arr[pivot] = arr[arr.count() - 1].also {arr[arr.count() - 1] =  arr[pivot]}
    pivot = arr.count()-1

    var ans = intArrayOf()
    var left = intArrayOf()
    for(i in 0 until arr.count())
    {
        if(arr[i] > arr[pivot] || i == pivot)
        {
            for(j in arr.count() - 2 downTo 0)
            {
                if(i>j || j == 0)
                {
                    arr[pivot] = arr[i].also {arr[i] =  arr[pivot]}
                    pivot = i
                    
                    if(pivot!=0){
                        left = arr.sliceArray(0..pivot-1)
                        ans = quickSort(arr.sliceArray(0..pivot - 1))
                        ans = ans + arr.sliceArray(pivot..pivot)
                    }
                    else
                    {
                        ans = arr.sliceArray(pivot..pivot)
                    }
                    if(pivot!=arr.count()-1){
                        ans = ans + quickSort(arr.sliceArray(pivot + 1..arr.count() - 1))
                    }
                    
                    return (ans)
                }
                if(arr[j]<arr[pivot])
                {
                    arr[i] = arr[j].also {arr[j] = arr[i]}
                    break
                }
            }
        }
    }
    return (intArrayOf())
}
