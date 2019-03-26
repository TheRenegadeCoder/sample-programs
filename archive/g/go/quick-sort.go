package main

import (
	"encoding/json"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func quickSort(list []int) []int {
	if len(list) <= 0 {
		return []int{}
	}

	var left []int
	var right []int
	pivot := len(list) / 2
	for i, n := range list {
		if i == pivot {
			continue
		}
		if n < list[pivot] {
			left = append(left, n)
		} else {
			right = append(right, n)
		}
	}
	left = quickSort(left)
	right = quickSort(right)
	return append(append(left, list[pivot]), right...)
}

func strToSliceInt(strList string) []int {
	list := regexp.MustCompile(", ?").Split(strList, -1)
	if len(list) < 2 {
		exitWithError()
	}
	var nums []int
	for _, num := range list {
		n, err := strconv.Atoi(num)
		if err != nil {
			exitWithError()
		}
		nums = append(nums, n)
	}
	return nums
}

func sliceIntToString(list []int) (out string) {
	bytes, _ := json.Marshal(list)
	out = strings.Replace(string(bytes), ",", ", ", -1)
	out = strings.Trim(out, "[]")
	return
}

func exitWithError() {
	fmt.Println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
	os.Exit(1)
}

func main() {
	if len(os.Args) != 2 {
		exitWithError()
	}

	nums := strToSliceInt(os.Args[1])
	nums = quickSort(nums)
	fmt.Println(sliceIntToString(nums))
}
