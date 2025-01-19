#include <stdio.h>
#include <stdlib.h>

int josephus(int n, int k) {
    if (n == 1)
        return 1;
    else
        return (josephus(n - 1, k) + k - 1) % n + 1;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: please input the total number of people and number of people to skip.\n");
        return 1;
    }

    char *endptr;
    int n = strtol(argv[1], &endptr, 10);
    if (*endptr != '\0' || n <= 0) {
        printf("Usage: please input the total number of people and number of people to skip.\n");
        return 1;
    }

    int k = strtol(argv[2], &endptr, 10);
    if (*endptr != '\0' || k <= 0) {
        printf("Usage: please input the total number of people and number of people to skip.\n");
        return 1;
    }

    int result = josephus(n, k);
    printf("%d\n", result);

    return 0;
}
