def isPalindrome(string):
    string = string.lower()
    if len(string) == 1:
        return True
    elif string[0] != string[-1]:
        return False
    else:
        return isPalindrome(string[1:-1])
