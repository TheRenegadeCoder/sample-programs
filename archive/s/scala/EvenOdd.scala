// Scala Program to check if input number is Odd or Even

import scala.util.{Try, Success, Failure}

object EvenOdd 
{
    def check_even_odd(num: Int): String = { 
        val result = if (num%2==0) "Even" else "Odd"
        return result
    }

    // Driver Code 
    def main(args: Array[String]) 
    {
        Try(args(0).toInt) match {
            case Failure(_) => println("Usage: please input a number")
            case Success(m) => println(check_even_odd(m))
        }
    }
} 
