import java.lang.NumberFormatException

fun main() {
    var n: Int
    var num: Int
    var digit: Int
    var rev: Int = 0

    print("Enter a positive number: ")
    try {
        num = readLine()!!.toInt()

        if (num.toString().length > 1){
            n = num

            do {
                digit = num % 10
                rev = (rev * 10) + digit
                num = num / 10
            }while (num != 0)

            println("The reverse of the number is: $rev")

            if (n == rev){
                println(true)
            }else{
                println(false)
            }
        }else{
            print("Enter a number with more than 1 figure")
        }


    }catch(e: NumberFormatException){
        println("Please input a number")
    }
}
