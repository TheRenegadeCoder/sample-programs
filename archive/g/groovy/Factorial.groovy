class Factorial {
    static def factorial(BigInteger n) {
        if (n == 0) {
            return 1
        }
        return n * factorial(n - 1)
    }

    static void main(args){
        if(args?.size() != 1 || !args[0].isInteger() || args[0].toInteger() < 0) {
          println "Usage: please input a non-negative integer"
          return
        }

        if(args[0].toInteger() >= 1000){
            println "Usage: please input a value below 1000"
            return
        }

        println factorial(args[0].toInteger())
    }
}