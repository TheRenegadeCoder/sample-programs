func isPalindrome(input: String) -> Bool {
    if input.isEmpty {
        print("Usage: please input a non-negative integer")
        return false
    }

    if let number = Int(input) {
        if number < 0 {
            print("Usage: please input a non-negative integer")
            return false
        }
    } else if Double(input) != nil {
        print("Usage: please input a non-negative integer")
        return false
    } else {
        print("Usage: please input a non-negative integer")
        return false
    }

    let numStr = input
    let numDigits = numStr.count
    let isEvenDigits = numDigits % 2 == 0
    
    let reversedStr = String(numStr.reversed())

    if numStr == reversedStr {
        return true
    } else {
        if isEvenDigits {
            print("Usage: please input a non-negative integer")
        } else {
            print("Usage: please input a non-negative integer")
        }
        return false
    }
}

print(isPalindrome(input: "7"))     
print(isPalindrome(input: "2442"))  
print(isPalindrome(input: "232"))   
print(isPalindrome(input: "5215"))  
print(isPalindrome(input: "521"))   
print(isPalindrome(input: ""))      
print(isPalindrome(input: "a")) 
print(isPalindrome(input: "-7"))    
print(isPalindrome(input: "5.41"))  
