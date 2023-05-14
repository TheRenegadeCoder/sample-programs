// Scala Program to calculate 
// Factorial of a number 

import scala.util.Try

// Creating object 
object Factorial 
{ 
  // Iterative way to calculate
  // factorial
  def factorial(n: Int): Int = { 
    var f = 1
    for(i <- 1 to n) 
    { 
        f = f * i; 
    } 

    return f 
  } 

  // Driver Code 
  def main(args: Array[String]) 
  {
    val m = Try(args(0).toInt).getOrElse(-1)
    if (m < 0) {
      println("Usage: please input a non-negative integer")
    }
    else {
      println(factorial(m))
    }
  } 
} 
