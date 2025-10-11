#include <iostream>
#include <sstream>
#include <vector>
#include <string>

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
        std::cout << "Usage: please enter the dimension of the matrix and the serialized matrix" << std::endl;
        return 1;
    }

    int cols = std::atoi(argv[1]);
    int rows = std::atoi(argv[2]);
    std::string input = argv[3];

    if (cols <= 0 || rows <= 0 || input.empty()) {
        std::cout << "Usage: please enter the dimension of the matrix and the serialized matrix" << std::endl;
        return 1;
    }

    int matrix[MAX_MATRIX_SIZE];
    int transposed[MAX_MATRIX_SIZE];
    int count = 0;

    std::stringstream ss(input);
    std::string token;

    while (std::getline(ss, token, ',') && count < rows * cols) {
        // Trim leading spaces
        size_t start = token.find_first_not_of(" ");
        if (start != std::string::npos) {
            token = token.substr(start);
        }
        matrix[count++] = std::atoi(token.c_str());
    }

    if (count != rows * cols) {
        std::cout << "Usage: please enter the dimension of the matrix and the serialized matrix" << std::endl;
        return 1;
    }

    transpose_matrix(matrix, rows, cols, transposed);

    for (int i = 0; i < cols * rows; i++) {
        std::cout << transposed[i];
        if (i < cols * rows - 1) {
            std::cout << ", ";
        }
    }
    std::cout << std::endl;

    return 0;
}
