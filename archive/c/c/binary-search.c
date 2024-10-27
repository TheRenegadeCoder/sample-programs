#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function prototypes
int binarySearch(const int arr[], int size, int target);
int compare(const void *a, const void *b);
int parseInput(const char *input, int **arr);
void freeMemory(int *arr);
int isSorted(const int arr[], int size);
int isValidNumber(const char *str);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <comma-separated integers> <target integer>\n", argv[0]);
        return 1;
    }

    int *arr = NULL;
    int size = 0;

    // Parse the input array from the first argument
    if (parseInput(argv[1], &arr) != 0) {
        return 1; // Exit if parsing fails
    }

    // Update size
    size = sizeof(arr) / sizeof(arr[0]);

    // Check if the array is sorted
    if (!isSorted(arr, size)) {
        printf("The array is not sorted. Sorting the array now...\n");
        qsort(arr, size, sizeof(int), compare);
    }

    // Get target value from the second argument
    int target;
    if (!isValidNumber(argv[2])) {
        printf("Invalid target input. Exiting.\n");
        freeMemory(arr);
        return 1;
    }
    target = atoi(argv[2]);

    // Perform binary search
    int result = binarySearch(arr, size, target);
    if (result != -1) {
        printf("Element found at index: %d\n", result);
    } else {
        printf("Element not found.\n");
    }

    // Free allocated memory
    freeMemory(arr);
    return 0;
}

// Function to perform binary search
int binarySearch(const int arr[], int size, int target) {
    int left = 0;
    int right = size - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (arr[mid] == target) {
            return mid; // Target found
        }

        if (arr[mid] < target) {
            left = mid + 1; // Move right
        } else {
            right = mid - 1; // Move left
        }
    }

    return -1; // Target not found
}

// Comparison function for qsort
int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

// Function to parse input string and populate the array
int parseInput(const char *input, int **arr) {
    char *token;
    int size = 0;
    int capacity = 10; // Initial capacity
    *arr = malloc(capacity * sizeof(int));
    if (*arr == NULL) {
        printf("Memory allocation failed. Exiting.\n");
        return 1;
    }

    // Tokenize the input string based on commas
    token = strtok((char *)input, ",");
    while (token) {
        if (!isValidNumber(token)) {
            printf("Invalid number detected: '%s'. Exiting.\n", token);
            freeMemory(*arr);
            return 1; // Exit if a number is invalid
        }

        if (size >= capacity) {
            capacity *= 2;
            *arr = realloc(*arr, capacity * sizeof(int));
            if (*arr == NULL) {
                printf("Memory reallocation failed. Exiting.\n");
                return 1;
            }
        }
        (*arr)[size++] = atoi(token);
        token = strtok(NULL, ",");
    }

    // Resize the array to the actual size
    *arr = realloc(*arr, size * sizeof(int));
    return 0; // Successful parsing
}

// Function to free allocated memory
void freeMemory(int *arr) {
    if (arr != NULL) {
        free(arr);
    }
}

// Function to check if the array is sorted
int isSorted(const int arr[], int size) {
    for (int i = 1; i < size; i++) {
        if (arr[i] < arr[i - 1]) {
            return 0; // Array is not sorted
        }
    }
    return 1; // Array is sorted
}

// Function to check if a string is a valid number
int isValidNumber(const char *str) {
    char *end;
    strtol(str, &end, 10); // Convert string to long
    return (*end == '\0' || *end == '\n'); // Check if the entire string was valid
}
