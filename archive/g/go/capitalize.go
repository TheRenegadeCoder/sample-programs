package main

import (
	"fmt"
	"os"
	"strings"
)

func exitWithError() {
	fmt.Println("Usage: provide a string")
	os.Exit(1)
}

func uppercaseFirst(str string) string {
	s := string(str[0])
	u := strings.ToUpper(s)
	up := u + str[1:]
	return up
}

func main() {
	if len(os.Args) != 2 {
		exitWithError()
	}

	s := os.Args[1]
	up := uppercaseFirst(s)

	fmt.Println(up)
}
