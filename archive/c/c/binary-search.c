#include <stdio.h>

// Function to perform binary search
int binarySearch(int arr[], int size, int target) {
    int left = 0;
    int right = size - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2; // To prevent overflow

        // Check if target is present at mid
        if (arr[mid] == target) {
            return mid; // Target found
        }

        // If target is greater, ignore the left half
        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            // If target is smaller, ignore the right half
            right = mid - 1;
        }
    }

    return -1; // Target not found
}

int main() {
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int size = sizeof(arr) / sizeof(arr[0]);
    int target = 5;

    int result = binarySearch(arr, size, target);
    if (result != -1) {
        printf("Element found at index: %d\n", result);
    } else {
        printf("Element not found.\n");
    }

    return 0;
}
