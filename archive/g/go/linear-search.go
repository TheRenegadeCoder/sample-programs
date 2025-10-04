package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func linearSearch(list []int, keyToSearch int) bool {
	for _, number := range list {
		if number == keyToSearch {
			return true
		}
	}
	return false
}

func main() {
	if len(os.Args) < 3 {
		fmt.Println("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
		return
	}

	numberString := os.Args[1]
	keyToSearchStr := os.Args[2]
	keyToSearch, err := strconv.Atoi(keyToSearchStr)
	if err != nil {
		fmt.Println("Usage: please provide a valid integer to find.")
		return
	}
	numberArray := strings.Split(numberString, ",")
	var listOfNumbers []int

	for _, numStr := range numberArray {
		numStr = strings.TrimSpace(numStr)
		number, err := strconv.Atoi(numStr)
		if err == nil {
			listOfNumbers = append(listOfNumbers, number)
		}
	}
	if len(listOfNumbers) > 0 {
		searched := linearSearch(listOfNumbers, keyToSearch)
		fmt.Println(searched)
	} else {
		fmt.Println("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
	}
}
