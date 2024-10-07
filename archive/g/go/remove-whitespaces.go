package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	errorMessage := "Usage: please provide a string"

	if len(os.Args) < 2 || os.Args[1] == "" {
		fmt.Println(errorMessage)
		os.Exit(1)
	}

	inputString := os.Args[1]
	outputString := strings.Join(strings.Fields(inputString), "")
	fmt.Println(outputString)
}
