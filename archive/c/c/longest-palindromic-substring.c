#include <stdio.h>
#include <string.h>

#define MAX_LENGTH 1000

// Function to expand around center and find palindrome length
int expandAroundCenter(const char* s, int left, int right) {
    while (left >= 0 && right < strlen(s) && s[left] == s[right]) {
        left--;
        right++;
    }
    return right - left - 1;
}

// Function to find the longest palindromic substring
void longestPalindromicSubstring(const char* s, char* result) {
    if (s == NULL || strlen(s) == 0) {
        strcpy(result, "");
        return;
    }

    int start = 0, maxLength = 1;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        int len1 = expandAroundCenter(s, i, i);     // Odd length palindrome
        int len2 = expandAroundCenter(s, i, i + 1); // Even length palindrome
        int len = (len1 > len2) ? len1 : len2;

        if (len > maxLength) {
            start = i - (len - 1) / 2;
            maxLength = len;
        }
    }

    strncpy(result, s + start, maxLength);
    result[maxLength] = '\0';
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: please provide a string that contains at least one palindrome\n");
        return 1;
    }

    const char* input = argv[1];
    char result[MAX_LENGTH];

    longestPalindromicSubstring(input, result);

    if (strlen(result) == 0) {
        printf("Usage: please provide a string that contains at least one palindrome\n");
    } else {
        printf("%s\n", result);
    }

    return 0;
}
