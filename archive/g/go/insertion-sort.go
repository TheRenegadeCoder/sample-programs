package main

import (
	"encoding/json"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func insertionSort(unsorted []int, sorted ...int) []int {
	if len(unsorted) <= 0 {
		return sorted
	}
	return insertionSort(unsorted[1:], insert(unsorted[0], sorted)...)
}

func insert(n int, list []int) []int {
	if len(list) <= 0 || n < list[0] {
		return append([]int{n}, list...)
	}
	return append([]int{list[0]}, insert(n, list[1:])...)
}

func exitWithError() {
	fmt.Println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
	os.Exit(1)
}

func main() {
	if len(os.Args) != 2 {
		exitWithError()
	}

	sNums := regexp.MustCompile(", ?").Split(os.Args[1], -1)
	if len(sNums) < 2 {
		exitWithError()
	}

	var nums []int
	for _, num := range sNums {
		n, err := strconv.Atoi(num)
		if err != nil {
			exitWithError()
		}
		nums = append(nums, n)
	}
	nums = insertionSort(nums)
	str, _ := json.Marshal(nums)

	fmt.Println(strings.Trim(string(str), "[]"))
}
