#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// Function prototypes
int binarySearch(const int arr[], int size, int target);
int parseInput(const char *input, int **arr, int *size);
void freeMemory(int *arr);
int isSorted(const int arr[], int size);
int isValidNumber(const char *str);
char* trimWhitespace(char *str);
void handleError(const char *message);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        handleError("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")");
    }

    int *arr = NULL;
    int size = 0;

    // Parse the input array from the first argument
    if (parseInput(argv[1], &arr, &size) != 0 || size < 1 || !isSorted(arr, size)) {
        handleError("Invalid input: Please provide a valid list of sorted integers.");
    }

    // Get target value from the second argument
    if (!isValidNumber(argv[2])) {
        handleError("Invalid number: Please provide a valid integer to find.");
    }
    int target = atoi(argv[2]);

    // Perform binary search
    printf(binarySearch(arr, size, target) != -1 ? "true\n" : "false\n");

    // Free allocated memory
    freeMemory(arr);
    return 0;
}

// Function to perform binary search
int binarySearch(const int arr[], int size, int target) {
    int left = 0, right = size - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) return mid; // Target found
        (arr[mid] < target) ? (left = mid + 1) : (right = mid - 1); // Move left or right
    }
    return -1; // Target not found
}

// Function to parse input string and populate the array
int parseInput(const char *input, int **arr, int *size) {
    char *token;
    int capacity = 10; // Initial capacity
    *arr = malloc(capacity * sizeof(int));
    if (!*arr) handleError("Memory allocation failed.");

    char *inputCopy = strdup(input);
    token = strtok(inputCopy, ",");
    *size = 0;

    while (token) {
        trimWhitespace(token);
        if (!isValidNumber(token)) {
            free(inputCopy);
            handleError("Invalid number detected.");
        }

        if (*size >= capacity) {
            capacity *= 2;
            *arr = realloc(*arr, capacity * sizeof(int));
            if (!*arr) handleError("Memory reallocation failed.");
        }
        (*arr)[(*size)++] = atoi(token);
        token = strtok(NULL, ",");
    }

    free(inputCopy);
    return 0; // Successful parsing
}

// Function to free allocated memory
void freeMemory(int *arr) {
    free(arr);
}

// Function to check if the array is sorted
int isSorted(const int arr[], int size) {
    for (int i = 1; i < size; i++) {
        if (arr[i] < arr[i - 1]) return 0; // Array is not sorted
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

// Function to handle errors
void handleError(const char *message) {
    fprintf(stderr, "%s\n", message);
    exit(1);
}
