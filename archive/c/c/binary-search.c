#include <stdio.h>
#include <stdlib.h>

// Function prototypes
int binarySearch(const int arr[], int size, int target);
int compare(const void *a, const void *b);
void getInputArray(int **arr, int *size);
void freeMemory(int *arr);
int isSorted(const int arr[], int size);

int main() {
    int *arr = NULL;
    int size = 0;

    getInputArray(&arr, &size);
    if (arr == NULL) {
        return 1; // Memory allocation failure handled in getInputArray
    }

    // Check if the array is sorted
    if (!isSorted(arr, size)) {
        printf("The array is not sorted. Sorting the array now...\n");
        qsort(arr, size, sizeof(int), compare);
    }

    // Get target value to search for
    int target;
    printf("Enter the target value to search: ");
    if (scanf("%d", &target) != 1) {
        printf("Invalid input. Exiting.\n");
        freeMemory(arr);
        return 1;
    }

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

// Function to get user input for the array
void getInputArray(int **arr, int *size) {
    printf("Enter the number of elements in the array: ");
    if (scanf("%d", size) != 1 || *size <= 0) {
        printf("Invalid size. Exiting.\n");
        return;
    }

    *arr = (int *)malloc(*size * sizeof(int));
    if (*arr == NULL) {
        printf("Memory allocation failed. Exiting.\n");
        return;
    }

    printf("Enter %d elements (unsorted): ", *size);
    for (int i = 0; i < *size; i++) {
        if (scanf("%d", &(*arr)[i]) != 1) {
            printf("Invalid input. Exiting.\n");
            freeMemory(*arr);
            *arr = NULL; // Set to NULL to avoid double free
            return;
        }
    }
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
