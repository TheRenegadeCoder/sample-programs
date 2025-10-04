#include <stdio.h>

int main(void)
{
    for (unsigned int i = 1; i <= 100; i++) {
        if (i % 15 == 0) {
            puts("FizzBuzz");
        } else if (i % 3 == 0) {
            puts("Fizz");
        } else if (i % 5 == 0) {
            puts("Buzz");
        } else {
            printf("%u\n", i);
        }
    }
    return 0;
}
