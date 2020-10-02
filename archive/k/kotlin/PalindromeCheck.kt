fun main(args: Array<String>){
    val result = isPalindrome("SAMPLE")

    print("is palindrome = $result")
}

fun isPalindrome (s: String) :Boolean {
    val n = s.length
    for (i in 0 until (n / 2))
    {
        if (s.get(i) != s.get(n - i - 1))
        {
            return false
        }
    }
    return true
}
