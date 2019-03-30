#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{    
    if (argc == 1 || sizeof(argv[1]) == 0 || (atoi(argv[1]) == 0 && !strcmp(argv[1], "0"))) {
        printf("Usage: please input a number\n");
    } else {
        int input = atoi(argv[1]);
        if (input % 2 == 0) {
            printf("Even\n");
        }
        else {
            printf("Odd\n");
        }
    }

    return 0;
}
