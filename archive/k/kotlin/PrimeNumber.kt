fun main(args: Array<String>) 
{
    var num = readLine()!!.toIntOrNull()
    if(num == null){
        print("Usage: please input a non-negative integer")
        return
    }
    if(num>1)
    {
        for(i in 2 until num)
        {
            if(num%i == 0)
            {
                println("Composite")
                return
            }
        }
        println("Prime")
    }
    else
    {
        println("Composite")
    }
}
