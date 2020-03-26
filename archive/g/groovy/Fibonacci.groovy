class Fibonacci {
    static void main(String[] args) {
        if (args.length < 1 || !args[0].isInteger()) {
            println 'please provide a positive integer'
        } else {
            def n = args[0] as Integer
            def first = 0G
            def second = 1G
            println first.class
            (1..n).each {
                second += first
                first = second - first
                println "$it: $first"
            }
        }
    }
}
