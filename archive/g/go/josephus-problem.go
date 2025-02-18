package main

import (
	"os"
	"strconv"
)

func die() {
	println("Usage: please input the total number of people and number of people to skip.")
	os.Exit(1)
}

func josephus(n, k int) int {
	if n == 1 {
		return 1
	}

	return (josephus(n-1, k)+k-1)%n + 1
}

func main() {
	if len(os.Args) != 3 {
		die()
	}

	n, err := strconv.Atoi(os.Args[1])
	if err != nil {
		die()
	}

	k, err := strconv.Atoi(os.Args[2])
	if err != nil {
		die()
	}

	println(josephus(n, k))
}
