import Foundation

func isPalindrome(_ input: String) -> Bool {
    return input == String(input.reversed())
}

func main() {
    let arguments = CommandLine.arguments

    guard arguments.count == 2 else {
        print("Usage: please input a non-negative integer")
        return
    }

    let input = arguments[1]
    
    if let number = Int(input), number >= 0 {
        
    
        // Check if the input is a palindrome
        if isPalindrome(input) {
            print("true")
        } else {
            print("false")
        }
    } else {
        // If the input is not a valid positive integer
        print("Usage: please input a non-negative integer")
    }
}

main()
