def longestPalindrome(string):
    longest = ""

    centres = [len(string) - 1]
    for diff in range(1, len(string)):
        centres.append(centres[0] + diff)
        centres.append(centres[0] - diff)

    for centre in centres:

        if(min(centre + 1, 2 * len(string) - 1 - centre) <= len(longest)):
            break
        if centre % 2 == 0:
            left, right = (centre // 2) - 1, (centre // 2) + 1
        else:
            left, right = centre // 2, (centre // 2) + 1

        while left >= 0 and right < len(string) and string[left] == string[right]:
            left -= 1
            right += 1

        if right - left > len(longest):
            longest = string[left + 1: right]

    return longest


if __name__ == '__main__':
    string = str(input("Enter String: "))
    if string == "" and string == None:
        print("Incorrect input provided. Program Terminated")
    sub = longestPalindrome(string)
    if len(sub) == 1:
        print("No Palindromic substring present.")
    else:
        print("Longest Palindromic Substring is: {}".format(sub))
