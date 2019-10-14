fun main(args: Array<String>){
        // Get input, or use default value
        val targetValue = when (args.isNotEmpty() && !args[0].isBlank()) {
            true -> args[0]
            false -> throw Error("No String Provided. Nothing to Capitalize")
        }

        // Kotlin provides a simple `capitalize()` function in the standard
        // library for all String objects
        println(targetValue.capitalize())
     }
