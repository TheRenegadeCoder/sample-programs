// ***********************************************************************************************************************************************************************
// Method 1 
// Using For Loop

fun main(args: Array<String>) {
    
    // Taking the input from the user
    val number = args[0].toInt()
    var factorial: Long = 1
    for (i in 1..number) {
        factorial *= i.toLong()
    }
    println("Factorial of $number is $factorial")
}


// ***********************************************************************************************************************************************************************
// Method 2
// Using While Loop

fun main(args: Array<String>) {

    // Taking the input from the user
    val number = args[0].toInt()
    var i = 1
    var factorial: Long = 1
    while (i <= number) {
        factorial *= i.toLong()
        i++
    }
    println("Factorial of $number is $factorial")
}
