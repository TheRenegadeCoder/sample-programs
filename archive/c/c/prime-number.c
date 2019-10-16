#include <stdio.h>
#include <stdlib.h>

void prime_number(int number)
{
    if (number < 0) {
        printf("Usage: please input a non-negative integer\n");
        return;
    } else if (number == 0 || number == 1) {
        printf("Composite\n");
        return;
    }

    for (int i = 2; i < number; i++) {
        if (number % i == 0) {
            printf("Composite\n");
            return;
        }
    }
    printf("Prime\n");
}

int is_int(char *str)
{
    if (str[0] > '9' || str[0] < '0')
            return (1);
    for (int i = 0; str[i]; i++) {
        if (str[i] > '9' || str[i] < '0')
            return (1);
    }
    return (0);
}

int main(int ac, char **av)
{
    if (ac != 2 || is_int(av[1]) != 0) {
        printf("Usage: please input a non-negative integer\n");
        return (1);
    }
	prime_number(atoi(av[1]));
	return (0);
}
