fun main(args: Array<String>) 
{
    var nums: IntArray
    try
    {
        nums = args[0].split(", ").map{ it.toInt() }.toIntArray()
        if (nums.size < 2) {
            throw Exception()
        }
    }
    catch(e: Exception)
    {
        println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
        return
    }
    var swapped:Boolean = false
    for(i in 0 until nums.count()-1)
    {
        swapped = false
        for(j in 0 until nums.count()-i-1)
        {
            if(nums[j]>nums[j+1])
            {
                //swap
                nums[j] = nums[j+1].also {nums[j+1] =  nums[j]}
                swapped = true
            }
        }
        if (swapped==false)
        {
            break
        }
    }
    for(i in 0 until nums.count())
    {
        if (i==nums.count()-1)
        {
            println("${nums[i]}")
            return
        }
        print("${nums[i]}, ")
    }
}
