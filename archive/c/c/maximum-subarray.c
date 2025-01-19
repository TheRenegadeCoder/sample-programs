#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

void print_usage() {
    printf("Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\"\n");
}

int max_subarray_sum(int* arr, int n) {
    int max_so_far = INT_MIN;
    int max_ending_here = 0;

    for (int i = 0; i < n; i++) {
        max_ending_here += arr[i];

        if (max_so_far < max_ending_here) {
            max_so_far = max_ending_here;
        }

        if (max_ending_here < 0) {
            max_ending_here = 0;
        }
    }

    return max_so_far;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        print_usage();
        return 1;
    }

    // Check if input is empty
    if (strlen(argv[1]) == 0) {
        print_usage();
        return 1;
    }

    // Parse input string
    char* token;
    int arr[100]; // Assuming a maximum of 100 integers
    int count = 0;

    token = strtok(argv[1], ",");
    while (token != NULL) {
        arr[count++] = atoi(token);
        token = strtok(NULL, ",");
    }

    // If less than two integers were provided
    if (count == 1) {
        printf("%d\n", arr[0]);
        return 0;
    } else if (count < 2) {
        print_usage();
        return 1;
    }

    // Calculate maximum subarray sum
    int result = max_subarray_sum(arr, count);

    printf("%d\n", result);

    return 0;
}
