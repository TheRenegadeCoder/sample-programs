#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>

void* sleepSort(void* arg) {
    int num = *(int*)arg;
    usleep(num * 1000000); // Sleep for num seconds
    printf("%d ", num); // Print the number after sleeping
    return NULL;
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

    pthread_t *threads = malloc(n * sizeof(pthread_t));

    for (int i = 0; i < n; i++) {
        pthread_create(&threads[i], NULL, sleepSort, &arr[i]);
    }

    for (int i = 0; i < n; i++) {
        pthread_join(threads[i], NULL); // Wait for all threads to finish
    }

    printf("\n");

    free(arr);
    free(threads);

    return 0;
}
