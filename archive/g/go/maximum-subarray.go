package main

import (
	"fmt"
	"os"
)

func main() {
	if len(os.Args) < 1 {
		fmt.Println("Please enter a list of comma-separated numbers", )
	}
	input := os.Args[1]
	fmt.Println(input)
	for i := 
}
