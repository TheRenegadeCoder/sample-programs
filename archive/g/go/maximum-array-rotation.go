package main

import (
	"fmt"
	"os"
	"unicode"
)

func main() {
	if len(os.Args) != 2 {
		printError()
	} else {
		if len(createSlice()) == 0 {
			printError()
		} else {
			fmt.Println(getMaxWeightedSum(createSlice()))
		}
	}
}

func createSlice() (slice []int) {
	stringSlice := os.Args[1]
	for _, char := range stringSlice {
		if unicode.IsDigit(char) {
			slice = append(slice, int(char)-'0')
		}
	}
	return
}

func getWeightedSum(slice []int) (sum int) {
	for i, num := range slice {
		sum += i * num
	}
	return
}

func getMaxWeightedSum(slice []int) (max int) {
	max = 0
	for i := 0; i < len(slice); i++ {
		if getWeightedSum(slice) > max {
			max = getWeightedSum(slice)
		}
		slice = rotateSlice(slice)
	}
	return
}

func rotateSlice(slice []int) (rotatedSlice []int) {
	first := slice[0]
	slice = slice[1:]
	slice = append(slice, first)
	rotatedSlice = slice
	return
}

func printError() {
	fmt.Println("Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")")
}
