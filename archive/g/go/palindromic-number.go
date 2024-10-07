package main

import (
	"fmt"
	"os"
	"strconv"
)

func palindromicNumber(x int) {
	if x >= 0 {
		reversedNumber := 0
		noOfDigits := 0
		temp := x

		for temp > 0 {
			noOfDigits++
			reversedNumber = (reversedNumber * 10) + (temp % 10)
			temp /= 10
		}

		if x == reversedNumber {
			fmt.Println("true")
		} else {
			fmt.Println("false")
		}
	} else {
		fmt.Println("Usage: please input a non-negative integer")
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: please input a non-negative integer")
		os.Exit(1)
	}

	x, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Println("Usage: please input a non-negative integer")
		os.Exit(1)
	}

	palindromicNumber(x)
}
