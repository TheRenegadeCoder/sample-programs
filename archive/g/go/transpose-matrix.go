package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	if len(os.Args) < 4 {
		fmt.Println("Usage: please enter the dimension of the matrix and the serialized matrix")
		return
	}

	cols, err1 := strconv.Atoi(os.Args[1])
	rows, err2 := strconv.Atoi(os.Args[2])
	matrixStr := os.Args[3]

	if err1 != nil || err2 != nil || cols <= 0 || rows <= 0 || matrixStr == "" {
		fmt.Println("Usage: please enter the dimension of the matrix and the serialized matrix")
		return
	}

	matrixStr = strings.ReplaceAll(matrixStr, " ", "")
	matrixElements := strings.Split(matrixStr, ",")
	if len(matrixElements) != cols*rows {
		fmt.Println("Usage: please enter the dimension of the matrix and the serialized matrix")
		return
	}

	matrix := make([][]int, rows)
	for i := range matrix {
		matrix[i] = make([]int, cols)
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			num, err := strconv.Atoi(matrixElements[i*cols+j])
			if err != nil {
				fmt.Println("Usage: please enter the dimension of the matrix and the serialized matrix")
				return
			}
			matrix[i][j] = num
		}
	}

	transposed := transpose(matrix)
	printMatrix(transposed)
}

func transpose(matrix [][]int) [][]int {
	if len(matrix) == 0 {
		return [][]int{}
	}

	transposed := make([][]int, len(matrix[0]))
	for i := range transposed {
		transposed[i] = make([]int, len(matrix))
	}

	for i := range matrix {
		for j := range matrix[i] {
			transposed[j][i] = matrix[i][j]
		}
	}

	return transposed
}

func printMatrix(matrix [][]int) {
	var result []string
	for _, row := range matrix {
		for _, val := range row {
			result = append(result, strconv.Itoa(val))
		}
	}
	fmt.Println(strings.Join(result, ", "))
}