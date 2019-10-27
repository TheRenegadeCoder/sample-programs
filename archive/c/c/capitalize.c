#include <stdio.h>
#include <string.h>
#include <ctype.h>

char *captialize(char str[]) {
    for(int i = 0; i < strlen(str); i++) {
        if(i == 0) {
            str[i] = toupper(str[i]);
        } else {
            continue;
        }
    }
    return str;
}

int main(int argc, char *argv[]) {
    if(argc == 2 && strlen(argv[1]) != 0) {
        printf("%s\n", captialize(argv[1]));
    } else if(argc > 2) {
        printf("Use quotes around multiple strings.\n");
    } else {
        printf("Usage: please provide a string\n");
    }

    return 0;
}
