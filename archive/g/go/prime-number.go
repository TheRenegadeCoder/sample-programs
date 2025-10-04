package main

import (
	"fmt"
	"os"
	"strconv"
)

func isPrime(n int) bool {
	if n < 2 {
		return false
	} else {
		for i := 2; i <= n/2; i++ {
			if n%i == 0 {
				return false
			}
		}
	}
	return true
}

func exitWithError() {
	fmt.Println("Usage: please input a non-negative integer")
	os.Exit(1)
}

func main() {
	if len(os.Args) != 2 {
		exitWithError()
	}

	n, err := strconv.Atoi(os.Args[1])
	if err != nil || n < 0 {
		exitWithError()
	}

	if isPrime(n) {
		fmt.Println("Prime")
	} else {
	    fmt.Println("Composite")
	}
}
