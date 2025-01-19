#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void sleepSort(int *arr, int n) {
    // Create an array to hold the sorted values
    int *sorted = malloc(n * sizeof(int));
    int sortedIndex = 0;

    // Find the maximum value to determine sleep duration
    int max = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max) max = arr[i];
    }

    // Sleep for each number and store it in the sorted array
    for (int i = 0; i <= max; i++) {
        for (int j = 0; j < n; j++) {
            if (arr[j] == i) {
                usleep(i * 1000000); // Sleep for arr[j] seconds
                sorted[sortedIndex++] = arr[j];
            }
        }
    }

    // Print with commas
    for (int i = 0; i < n; i++) {
        printf("%d%s", sorted[i], (i < n - 1) ? ", " : "");
    }
    printf("\n");

    free(sorted);
}

void parseInput(const char *input, int **arr, int *n) {
    char *token;
    char *inputCopy = strdup(input);
    token = strtok(inputCopy, ",");

    while (token != NULL) {
        (*arr)[(*n)++] = atoi(token);
        token = strtok(NULL, ",");
    }

    free(inputCopy);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n");
        return 1;
    }

    const char *input = argv[1];
    if (strlen(input) == 0 || input[0] == ' ') {
        printf("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n");
        return 1;
    }

    int *arr = malloc(100 * sizeof(int)); // Allocate memory for up to 100 integers
    int n = 0;

    parseInput(input, &arr, &n);

    if (n < 2) {
        printf("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n");
        free(arr);
        return 1;
    }

    sleepSort(arr, n);

    free(arr);
    return 0;
}
