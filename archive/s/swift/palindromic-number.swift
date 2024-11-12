func isPalindromeNumber(number : Int) -> bool {
    var numStr = String(number)
    var reversedStr = String(numStr.reversed())
    return numStr == reversedStr
}

print(isPalindromeNumber(number: 434))
print(isPalindromeNumber(number: 322))
