package main

import (
	"fmt"
	"os"
	"strconv"
)

func main () {
	var IsPrime bool = true

	if len(os.Args) != 2 {
		fmt.Printf("Usage: %s [integer]\n", os.Args[0])
		os.Exit(1)
	}

	n, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Printf("%s\n", err)
		fmt.Printf("Usage: %s [integer]\n", os.Args[0])
		os.Exit(1)
	}

	for i := 2; i <= n / 2; i++ {
		if n % i == 0 {
			IsPrime = false
			break
		}
	}

	if !IsPrime {
		fmt.Printf("Composite\n");
	} else {
		fmt.Printf("Prime\n");
	}
}
