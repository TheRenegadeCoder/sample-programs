import Foundation

func isPrime(_ n: Int) -> Bool {
    if n <= 1 {
        return false
    }

    for i in 2...Int(Double(n).squareRoot()) {
        if n % i == 0 {
            return false
        }
    }

    return true
}

if CommandLine.arguments.count != 2 {
    print("Usage: please input a number")
} else if let number = Int(CommandLine.arguments[1]) {
    if isPrime(number) {
        print("Prime")
    } else {
        print("Composite")
    }
} else {
    print("Invalid input")
}