#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_MATRIX_SIZE 100

void transpose_matrix(int *matrix, int rows, int cols, int *transposed) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            transposed[j * rows + i] = matrix[i * cols + j];
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        printf("Usage: please enter the dimension of the matrix and the serialized matrix\n");
        return 1;
    }

    int cols = atoi(argv[1]);
    int rows = atoi(argv[2]);
    char *input = argv[3];

    if (cols <= 0 || rows <= 0 || strlen(input) == 0) {
        printf("Usage: please enter the dimension of the matrix and the serialized matrix\n");
        return 1;
    }

    int matrix[MAX_MATRIX_SIZE];
    int transposed[MAX_MATRIX_SIZE];
    int count = 0;
    char *token = strtok(input, ", ");

    while (token != NULL && count < rows * cols) {
        matrix[count++] = atoi(token);
        token = strtok(NULL, ", ");
    }

    if (count != rows * cols) {
        printf("Usage: please enter the dimension of the matrix and the serialized matrix\n");
        return 1;
    }

    transpose_matrix(matrix, rows, cols, transposed);

    for (int i = 0; i < cols * rows; i++) {
        printf("%d", transposed[i]);
        if (i < cols * rows - 1) {
            printf(", ");
        }
    }
    printf("\n");

    return 0;
}
