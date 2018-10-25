#include <stdio.h>
#include <stdlib.h>

int main()
{
    int input;
    printf("Enter a Number: ");
    scanf("%d", &input);

    if (input % 2 == 0) {
        printf("%d is a Even.", input);
    }
    else {
        printf("%d is Odd.", input);
    }

    return 0;
}
