def checkPalindrome(s):
    return "Palindrome" if s==s[::-1] else "Not Palindrome"

print(checkPalindrome("madam"))
print(checkPalindrome("abcd"))
