package main

import (
	"fmt"
	"os"
	"strconv"
)

func main () {
	if len(os.Args) != 2 {
		fmt.Printf("Usage: %s [integer]\n", os.Args[0])
		os.Exit(0)
	}
	
	n, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Printf("%s\n", err)
		fmt.Printf("Usage: %s [integer]\n", os.Args[0])
		os.Exit(1)
	}

	if n % 2 == 0 {
		fmt.Printf("Even\n")
	} else {
		fmt.Printf("Odd\n")
	}
}
