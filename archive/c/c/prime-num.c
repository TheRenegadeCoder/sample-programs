#include <stdio.h>
#include <stdlib.h>

int main()
{
    int input, i, isPrime=0;
    printf("Enter a Number: ");
    scanf("%d", &input);

    for (i = 2; i <= input/2; i++) {
        if(input % i == 0) {
            isPrime = 1;
            break;
        }
    }

    if(isPrime == 0) {
        printf("%d is a Prime Number.", input);
    }
    else {
        printf("%d is not a Prime Number.", input);
    }

    return 0;

}
