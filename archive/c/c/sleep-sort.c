#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <process.h>

void sleepSort(int num) {
    Sleep(num * 1000); // Sleep for num seconds
    printf("%d ", num); // Print the number after sleeping
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

    HANDLE *threads = malloc(n * sizeof(HANDLE));

    for (int i = 0; i < n; i++) {
        threads[i] = (HANDLE)_beginthread((void(*)(void*))sleepSort, 0, (void*)(intptr_t)arr[i]);
    }

    WaitForMultipleObjects(n, threads, TRUE, INFINITE); // Wait for all threads to finish

    printf("\n");

    free(arr);
    free(threads);

    return 0;
}
