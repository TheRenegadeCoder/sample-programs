fun main() {
    var n: Int
    var num: Int
    var digit: Int
    var rev: Int = 0

    print("Enter a positive number: ")
    num = readLine()!!.toInt()

    n = num

    do {
        digit = num % 10
        rev = (rev * 10) + digit
        num = num / 10
    }while (num != 0)

    if (n == rev){
        println(true)
    }else{
        println(false)
    }
}
