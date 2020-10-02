#include <stdio.h>

int fibonacci(int n)
{
    return ( n<=2 ? 1 : fibonacci(n-1) + fibonacci(n-2) );
}

int main(void)
{
    int n;
    for (n=1; n<=16; n++)
        printf("%d, ", fibonacci(n));
    printf("...\n");
    return 0;
}