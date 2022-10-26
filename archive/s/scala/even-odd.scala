// Scala Program to check if input number is Odd or Even
object evenodd 
{ 

	def check_even_odd(n: Int): Int = { 
		result = if (num%2==0) "Even" else "Odd"
    return result
	} 

	// Driver Code 
	def main(args: Array[String]) 
	{   val m= args(0).toInt
		println(evenodd(m)) 
	} 

} 
