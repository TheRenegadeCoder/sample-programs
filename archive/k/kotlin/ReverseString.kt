fun main(args: Array<String>){
  // Get input, or use default value
  val targetValue = when (args.size > 0 && !args[0].isNullOrBlank()) {
    true -> args[0]
    false -> throw Error("No String Provided. Nothing to Reverse")
  }  
  
  // Kotlin provides a simple `reversed()` function in the standard
  // library for all String/CharSequence objects
  println(targetValue.reversed())
}