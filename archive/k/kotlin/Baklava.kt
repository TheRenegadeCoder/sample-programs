fun main (args: Array<String>)
{
    for (i in 0..9)
        println (" ".repeat (10 - i) + "*".repeat (i * 2 + 1));

    for (i in 10 downTo 0)
        println (" ".repeat (10 - i) + "*".repeat (i * 2 + 1));
}
