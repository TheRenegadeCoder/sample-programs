fun main(args: Array<String>) {
    var n: Int
    var num: Int
    var digit: Int
    var rev: Int = 0

    try {
        num = args[0].toInt()

        if (num.toString().length > 1){
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
        }else{
            println("Usage: please input a number with at least two digits")
        }


    }catch(e: Exception){
        println("Usage: please input a number with at least two digits")
    }
}
