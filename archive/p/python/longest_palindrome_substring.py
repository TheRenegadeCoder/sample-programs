import sys

errorMessage = "Usage: please provide a string that contains at least one palindrome"

def longestPalindrome(string):
    longest = ""
    string = string.lower()

    centres = [len(string) - 1]
    for diff in range(1, len(string)):
        centres.append(centres[0] + diff)
        centres.append(centres[0] - diff)

    for centre in centres:
        if (min(centre + 1, 2 * len(string) - 1 - centre) <= len(longest)):
            break
        if centre % 2 == 0:
            left, right = (centre // 2) - 1, (centre // 2) + 1
        else:
            left, right = centre // 2, (centre // 2) + 1

        while left >= 0 and right < len(
                string) and string[left] == string[right]:
            left -= 1
            right += 1

        if right - left > len(longest):
            longest = string[left + 1:right]

    return longest


if __name__ == '__main__':
    if (len(sys.argv) < 2):
        print(errorMessage)
    else:
        string = sys.argv[1]
        if string == "" or string == None:
            print(errorMessage)
        sub = longestPalindrome(string)
        if len(sub) == 1:
            print(errorMessage)
        else:
            print(sub)
