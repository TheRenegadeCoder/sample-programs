fun main(args: Array<String>) 
{
    var nums: IntArray
    try
    {
        nums = readLine()!!.split(", ").map{ it.toInt() }.toIntArray()
    }
    catch(e: Exception)
    {
        println("Usage: please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”")
        return
    }
    var min:Int
    for(i in 0 until nums.count()-1)
    {
        min = i
        for(j in i+1 until nums.count())
        {
            if(nums[j]<nums[min])
            {
                min = j
            }
            if(min!=i)
            {
                nums[i] = nums[min].also {nums[min] =  nums[i]}
            }
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