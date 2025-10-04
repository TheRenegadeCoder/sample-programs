// for System.exit()
import Foundation


/*
    Check if there is exactly one argument and if it can be parsed as an integer
*/
guard CommandLine.argc == 2, let number = Int(CommandLine.arguments[1]) else {
    print("Usage: please input a number")
    exit(0)
}

let is_even = number % 2 == 0

if is_even {
    print("Even")
} else {
    print("Odd")
}