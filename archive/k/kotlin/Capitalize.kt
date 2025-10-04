fun main(args: Array<String>) {
    if (args.isNullOrEmpty() || args[0].isBlank()) {
        println("Usage: please provide a string")
    } else {
        // Kotlin provides a simple `capitalize()` function in the standard
        // library for all String objects
        println(args[0].capitalize())
    }
}
