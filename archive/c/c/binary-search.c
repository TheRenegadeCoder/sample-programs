#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// Function prototypes
int binarySearch(const int arr[], int size, int target);
int isSorted(const int arr[], int size);
int isValidNumber(const char *str);
char* trimWhitespace(char *str);
int parseInput(const char *input, int **arr, int *size);
void freeMemory(int *arr);
void printErrorAndExit(const char *message, int *arr);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printErrorAndExit("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n", NULL);
    }

    int *arr = NULL;
    int size = 0;

    // Parse the input array from the first argument
    if (parseInput(argv[1], &arr, &size) != 0 || size < 1 || !isSorted(arr, size)) {
        printErrorAndExit("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n", arr);
    }

    // Get target value from the second argument
    if (!isValidNumber(argv[2])) {
        printErrorAndExit("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n", arr);
    }

    int target = atoi(argv[2]);

    // Perform binary search
    int result = binarySearch(arr, size, target);
    printf(result != -1 ? "true\n" : "false\n");

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

// Function to parse input string and populate the array
int parseInput(const char *input, int **arr, int *size) {
    char *token;
    int capacity = 10; // Initial capacity
    *arr = malloc(capacity * sizeof(int));
    if (*arr == NULL) {
        printf("Memory allocation failed. Exiting.\n");
        return 1;
    }

    // Tokenize the input string based on commas
    char *inputCopy = strdup(input);
    token = strtok(inputCopy, ",");
    *size = 0;
    while (token) {
        trimWhitespace(token); // Trim whitespace around token
        if (!isValidNumber(token)) {
            printf("Invalid number detected: '%s'. Exiting.\n", token);
            freeMemory(*arr);
            free(inputCopy);
            return 1; // Exit if a number is invalid
        }

        if (*size >= capacity) {
            capacity *= 2;
            *arr = realloc(*arr, capacity * sizeof(int));
            if (*arr == NULL) {
                printf("Memory reallocation failed. Exiting.\n");
                free(inputCopy);
                return 1;
            }
        }
        (*arr)[(*size)++] = atoi(token);
        token = strtok(NULL, ",");
    }

    // Resize the array to the actual size
    *arr = realloc(*arr, *size * sizeof(int));
    free(inputCopy); // Free the input copy
    return 0; // Successful parsing
}

// Function to free allocated memory
void freeMemory(int *arr) {
    free(arr);
}

// Function to print error message and exit
void printErrorAndExit(const char *message, int *arr) {
    if (arr != NULL) {
        freeMemory(arr);
    }
    printf("%s", message);
    exit(1);
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

// Function to trim whitespace from a string
char* trimWhitespace(char *str) {
    // Trim leading whitespace
    while (isspace((unsigned char)*str)) str++;
    // Trim trailing whitespace
    char *end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) end--;
    *(end + 1) = '\0'; // Null terminate after the last non-space character
    return str;
}
