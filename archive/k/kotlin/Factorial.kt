import java.math.BigInteger

fun main(args: Array<String>) {
    if (args.isNullOrEmpty() || args[0].toIntOrNull()?.takeIf { it >= 0 } == null) {
        println("Usage: please input a non-negative integer")
        return
    }

    val num = args[0].toInt()
    var factorial = BigInteger.ONE
    for (i in 1..num) {
        // factorial = factorial * i;
        factorial = factorial.multiply(BigInteger.valueOf(i.toLong()))
    }
    println(factorial)
}