// Scala Program to calculate 
// Factorial of a number 

// Creating object 
object GFG 
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
	{   val m= args(0).toInt
		println(factorial(m)) 
	} 

} 
