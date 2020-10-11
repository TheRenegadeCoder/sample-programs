func fibonacciProgram(n: Int) {
    var f1=1, f2=1, fib=0
    for i in 3...n {
        fib = f1 + f2
        print("Fibonacci: \(i) = \(fib)")
        f1 = f2
        f2 = fib
    }
}


func fibonacciRecursive(n: Int) -> Int {
    if (n == 0){
        return 0
    } else if (n == 1) {
        return 1
    }
    return fibonacciR(n-1) + fibonacciR(n-2)
}