fun main(args: Array<String>)  
{
    // store usage message in variable
    val message = "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"
       
    // validate input array is correct size and does not contain empty Strings 
    if(args.size !=2 || args[0].isBlank() || args[1].isBlank())
    {
        println(message)
        return
    } 
    
    // convert input number String into a List of integers, invalid characters are converted to null
    val intList = args[0].split(",").map { it.trim().toIntOrNull() }
 
    // convert input key String into an int, invalid characters are converted to null
    val key = args[1].toIntOrNull()
 
    // check if the List or the key contains null (invalid) elements
    if(null in intList || key == null)
    {
        println(message)
        return
    }

    // check if key is in the List and print returned boolean   
    println(key in intList)
}