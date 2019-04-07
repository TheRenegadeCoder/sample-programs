package main

import (
	"fmt"
	"os"
	"strconv"
)

func fibonacci(n int, c chan int) {
	x, y := 1, 1
	for i := 0; i < n; i++ {
		c <- x
		x, y = y, x+y
	}
	close(c)
}

func exitWithError() {
	fmt.Println("Usage: please input the count of fibonacci numbers to output")
	os.Exit(1)
}

func main() {
	if len(os.Args) != 2 {
		exitWithError()
	}

	n, err := strconv.Atoi(os.Args[1])
	if err != nil {
		exitWithError()
	}

	c := make(chan int, n)

	go fibonacci(cap(c), c)
	i := 1
	for v := range c {
		fmt.Printf("%d: %d\n", i, v)
		i++
	}
}
