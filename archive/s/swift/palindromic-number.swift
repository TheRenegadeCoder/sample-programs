func isPalindrome(input: String) -> Bool {
    if input.isEmpty {
        return false  // No output for empty input
    }

    if let number = Int(input) {
        if number < 0 {
            print("Usage: please input a non-negative integer")
            return false
        }
        
        if input.count == 1 {
            return true;
        }
    } else {
        // Handles floats, letters, and other non-integer inputs
        print("Usage: please input a non-negative integer")
        return false
    }

    let numStr = input
    let reversedStr = String(numStr.reversed())

    return numStr == reversedStr
}

// Test cases
print(isPalindrome(input: "7"))      // returns true
print(isPalindrome(input: "2442"))   // Returns true
print(isPalindrome(input: "232"))    // Returns true
print(isPalindrome(input: "5215"))   // Returns false
print(isPalindrome(input: "521"))    // Returns false
print(isPalindrome(input: ""))       // No output
print(isPalindrome(input: "a"))      // Outputs usage message
print(isPalindrome(input: "-7"))     // Outputs usage message
print(isPalindrome(input: "5.41"))   // Outputs usage message
