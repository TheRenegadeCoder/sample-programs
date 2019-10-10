#include <stdio.h>
#include <string.h>

void rot13(char *str) {
    for(int i = 0; str[i] != '\0'; i++) {
        char c = *(str + i);
        if(('a' <= c && 'n' > c) || ('A' <= c && 'N' > c)) {
            *(str + i) += 13;
        } else if(('n' <= c && 'z' >= c) || ('N' <= c && 'Z' >= c)) {
            *(str + i) -= 13;
        }
    }
}

int main(int argc, char *argv[]) {
    if(argc == 2) {
        rot13(argv[1]);
        printf("Result: %s\n", argv[1]);
    } else if(argc > 2) {
        printf("Use quotes around multiple strings.\n");
    } else {
        printf("Usage: please provide a string to encrypt.\n");
    }
}