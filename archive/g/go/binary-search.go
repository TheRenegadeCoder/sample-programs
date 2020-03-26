package main

import (
	"encoding/json"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func binarySearch(list []int, target int) bool {
	midIndex := len(list) / 2
	midpoint := list[midIndex]

	if midpoint == target {
		return true
	}

	if len(list) <= 1 {
		return false
	}

	if target < list[midIndex] {
		return binarySearch(list[:midIndex], target)
	}

	return binarySearch(list[midIndex:], target)
}

func verifySortedList(list []int) {
	lastVal := list[0]
	for _, val := range list {
		if val < lastVal {
			exitWithError()
		}
	}
}

func strToSliceInt(strList string) []int {
	list := regexp.MustCompile(", ?").Split(strList, -1)
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
	fmt.Println("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
	os.Exit(1)
}

func main() {
	if len(os.Args) != 3 {
		exitWithError()
	}

	list := strToSliceInt(os.Args[1])
	verifySortedList(list)
	target, err := strconv.Atoi(os.Args[2])
	if err != nil {
		exitWithError()
	}
	fmt.Println(binarySearch(list, target))
}
