#include <iostream>
#include <string>
#include <cstring>

#define MAX_LENGTH 1000

int expandAroundCenter(const std::string& s, int left, int right) {
    while (left >= 0 && right < s.length() && s[left] == s[right]) {
        left--;
        right++;
    }
    return right - left - 1;
}

bool longestPalindromicSubstring(const std::string& s, std::string& result) {
    if (s.empty()) {
        result = "";
        return false;
    }

    int start = 0, maxLength = 0;
    int len = s.length();

    for (int i = 0; i < len; i++) {
        int len1 = expandAroundCenter(s, i, i);
        int len2 = expandAroundCenter(s, i, i + 1);
        int len = (len1 > len2) ? len1 : len2;

        if (len > maxLength) {
            start = i - (len - 1) / 2;
            maxLength = len;
        }
    }

    if (maxLength > 1) {
        result = s.substr(start, maxLength);
        return true;
    }

    result = "";
    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cout << "Usage: please provide a string that contains at least one palindrome" << std::endl;
        return 1;
    }

    std::string input = argv[1];
    std::string result;

    if (longestPalindromicSubstring(input, result) && !result.empty()) {
        std::cout << result << std::endl;
    } else {
        std::cout << "Usage: please provide a string that contains at least one palindrome" << std::endl;
    }

    return 0;
}
