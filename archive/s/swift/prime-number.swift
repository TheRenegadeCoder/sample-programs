import Foundation

let usage = "Usage: please input a non-negative integer"

if CommandLine.arguments.count != 2 {
    print(usage)
    exit(0)
}

guard let number = Int(CommandLine.arguments[1]), number >= 0 else {
    print(usage)
    exit(0)
}

if number < 2 {
    print("composite")
    exit(0)
}

var isPrime = true
let limit = Int(Double(number).squareRoot())

if limit >= 2 {
    for i in 2...limit {
        if number % i == 0 {
            isPrime = false
            break
        }
    }
}

print(isPrime ? "prime" : "composite")