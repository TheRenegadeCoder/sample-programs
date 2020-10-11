import Foundation

func fibonacciProgram(_ n: Int) {
    var f1=0, f2=1, fib=1
    for i in 0..<n {
        print("\(i+1): \(fib)")
        fib = f1 + f2
        f1 = f2
        f2 = fib
    }
}


func fibonacciRecursive(_ n: Int) -> Int {
    if (n == 0) {
        return 0
    } else if (n == 1) {
        return 1
    }
    return fibonacciRecursive(n-1) + fibonacciRecursive(n-2)
}

/*
    Check if there is exactly one argument and if it can be parsed as an integer
*/
guard CommandLine.argc == 2, let number = Int(CommandLine.arguments[1]) else {
    print("Usage: please input the count of fibonacci numbers to output")
    exit(0)
}

fibonacciProgram(number)