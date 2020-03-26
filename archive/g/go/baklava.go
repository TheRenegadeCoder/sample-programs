package main

import (
	"fmt"
	"strings"
)

func main() {
	for i := 0; i < 10; i++ {
		fmt.Println(strings.Repeat(" ", (10-i)) + strings.Repeat("*", (i*2+1)))
	}

	for i := 10; -1 < i; i-- {
		fmt.Println(strings.Repeat(" ", (10-i)) + strings.Repeat("*", (i*2+1)))
	}
}
