//Using BigInteger

import java.math.BigInteger

fun main(args: Array<String>) {
    val num = 30
    var factorial = BigInteger.ONE
    for (i in 1..num) {
        // factorial = factorial * i;
        factorial = factorial.multiply(BigInteger.valueOf(num.toLong()))
    }
    println("Factorial of $num = $factorial")
}
