/*

Linear search is quite intuitive, it is basically searching an element in an array by traversing 
the array from the beginning to the end and comparing each item in the array with the key. If a 
particular array entry matches with the key the position is recorded and the loop is stopped. 
The algorithm for this is:

Define a flag (set it's value to 0) for checking if key is present in array or notation.
Iterate through every element in array.
In each iteration compare the key and the current element.
If they match set the flag to 1, position to the current iteration and break from the loop.
If entire loop is traversed and the element is not found the value of flag will be 0 and user can notified that key is not in array.

*/


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
    
    // convert list of numbers string input into an int array, invalid entries converted to null
    val intArray = args[0].split(",").map { it.trim().toIntOrNull() }

    // check if array contains null (invalid) elements
    if(null in intArray)
    {
        println(message)
        return
    }
    
    // convert key string input into an int, invalid entries converted to null
    val key = args[1].toIntOrNull()
 
    // check if key is null (invalid)
    if(key == null)
    {
        println(message)
        return
    }

    // check if key is in the array and print returned boolean   
    println(key in intArray)
}