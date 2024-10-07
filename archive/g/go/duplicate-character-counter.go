package main

import (
	"fmt"
	"os"
)

func errorMessage() {
	fmt.Println("Usage: please provide a string")
}

func main() {
	if len(os.Args) <= 1 {
		errorMessage()
		return
	}

	inputStr := os.Args[1]

	if len(inputStr) == 0 {
		errorMessage()
		return
	}
	charCount := make(map[rune]int)
	for _, c := range inputStr {
		charCount[c]++
	}
	duplicateFound := false
	for _, c := range inputStr {
		if count, exists := charCount[c]; exists && count > 1 {
			if !duplicateFound {
				duplicateFound = true
			}
			fmt.Printf("%c: %d\n", c, count)
			charCount[c] = 0
		}
	}

	if !duplicateFound {
		fmt.Println("No duplicate characters")
	}
}
