func isPalindromeNumber(input : Int) -> Bool {
    if let number = Int(input) {

    if number < 0 {
        return false
    }

    var numStr = String(number)
    var reversedStr = String(numStr.reversed())
    return numStr == reversedStr
    
    } else {
        print("Error: Input is not a valid Number!")
        return false;
    }
}

print(isPalindromeNumber(number: 434))
print(isPalindromeNumber(number: 322))
