#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool linear_search(int* arr, int size, int target) {
    for (int i = 0; i < size; i++) {
        if (arr[i] == target) {
            return true;
        }
    }
    return false;
}

int* parse_array(char* input, int* size) {
    int* arr = NULL;
    *size = 0;
    char* token = strtok(input, ", ");
    while (token != NULL) {
        arr = realloc(arr, (*size + 1) * sizeof(int));
        arr[*size] = atoi(token);
        (*size)++;
        token = strtok(NULL, ", ");
    }
    return arr;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n");
        return 1;
    }

    int size;
    int* arr = parse_array(argv[1], &size);
    int target = atoi(argv[2]);

    if (size == 0) {
        printf("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n");
        free(arr);
        return 1;
    }

    bool result = linear_search(arr, size, target);
    printf("%s\n", result ? "true" : "false");

    free(arr);
    return 0;
}
