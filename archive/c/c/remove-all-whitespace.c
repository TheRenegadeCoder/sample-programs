#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    // check whether the passed argument is a string
    if (argc < 2) {
        printf("Usage: please provide a string\n");
        return 1; 
    }

    char *input = argv[1]; 
    char output = [1000];  
    int j = 0; 

    for (int i = 0; input[i] != '\0'; i++) {
        // check if current character is not a whitespace character
        if (!isspace(input[i])) {
            output[j++] = input[i];
        }
    }
    return 0;
}
