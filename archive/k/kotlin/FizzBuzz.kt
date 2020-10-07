fun main(args: Array<String>){
    for (i in 1..100){
        when {
            (i % 3 == 0 && i % 5 == 0) -> println("FizzBuzz")
            i % 3 == 0 -> println("Fizz")
            i % 5 == 0 -> println("Buzz")
            else -> println("$i")
        }
    }
}