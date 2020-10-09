// Pseudo code
// Input: number
// Formula: Factorial = 1*2*....*number
// Case: 0! = 1

// ***********************************************************************************************************************************************************************
// Method 1 
// Using For Loop

fun main(args: Array<String>) {
    
    // Taking the input from the user
    val number = args[0].toInt()
    var factorial: Long = 1
    for (i in 0..number) {
        if (i == 0){
        	factorial = 1}
       else{
        factorial *= i.toLong()
       }
    }
    println("Factorial of $number is $factorial")
}


// ***********************************************************************************************************************************************************************
// Method 2
// Using While Loop

// fun main(args: Array<String>) {

//     // Taking the input from the user
//     val number = args[0].toInt()
//     var i = 1
//     var factorial: Long = 1
//     while (i <= number) {
//         if (i == 0){
//         	factorial = 1}
//        else{
//         factorial *= i.toLong()
//        }
        
//         i++
//     }
//     println("Factorial of $number is $factorial")
// }



// The second method is commented so that the first method can be run directly from the command line by just passing a number as an input
