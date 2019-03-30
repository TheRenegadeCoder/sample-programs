#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int input = atoi(argv[1]);

    if (input % 2 == 0) {
        printf("Even\n");
    }
    else {
        printf("Odd\n");
    }

    return 0;
}
