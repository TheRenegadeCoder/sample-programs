fun main() {
    var n: Long
    var num: Long
    var digit: Long
    var rev: Long = 0

    print("Enter a positive number: ")
    num = readLine()!!.toLong()

    n = num

    do {
        digit = num % 10
        rev = (rev * 10) + digit
        num = num / 10
    }while (num != 0L)

    println("The reverse of the number is: $rev")

    if (n == rev){
        println("The number is a palindrome")
    }else{
        println("The number is not a palindrome")
    }
}
