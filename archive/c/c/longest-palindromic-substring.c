#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_LENGTH 1000

int expandAroundCenter(const char* s, int left, int right) {
    while (left >= 0 && right < strlen(s) && s[left] == s[right]) {
        left--;
        right++;
    }
    return right - left - 1;
}

bool longestPalindromicSubstring(const char* s, char* result) {
    if (s == NULL || strlen(s) == 0) {
        strcpy(result, "");
        return false;
    }

    int start = 0, maxLength = 0;
    int len = strlen(s);

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
        strncpy(result, s + start, maxLength);
        result[maxLength] = '\0';
        return true;
    }

    strcpy(result, "");
    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: please provide a string that contains at least one palindrome\n");
        return 1;
    }

    const char* input = argv[1];
    char result[MAX_LENGTH];

    if (longestPalindromicSubstring(input, result) && strlen(result) > 0) {
        printf("%s\n", result);
    } else {
        printf("Usage: please provide a string that contains at least one palindrome\n");
    }

    return 0;
}
