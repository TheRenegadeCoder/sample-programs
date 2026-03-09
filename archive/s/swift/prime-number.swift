import Foundation

if CommandLine.arguments.count != 2 {
    print("Usage: please input a non-negative integer")
    exit(0)
}

guard let number = Int(CommandLine.arguments[1]), number >= 0 else {
    print("Usage: please input a non-negative integer")
    exit(0)
}

if number < 2 {
    print("composite")
    exit(0)
}

for i in 2...Int(Double(number).squareRoot()) {
    if number % i == 0 {
        print("composite")
        exit(0)
    }
}

print("prime")