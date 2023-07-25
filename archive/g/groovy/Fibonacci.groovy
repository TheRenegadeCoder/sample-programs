class Fibonacci {
    static void main(String[] args) {
        if (args.length < 1 || !args[0].isInteger()) {
            println 'Usage: please input the count of fibonacci numbers to output'
        } else {
            def n = args[0] as Integer
            if (n > 0) {
                def first = 0G
                def second = 1G
                (1..n).each {
                    second += first
                    first = second - first
                    println "$it: $first"
                }
            }
        }
    }
}
