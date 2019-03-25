package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func lcs(list1 []int, list2 []int) (lcsList []int) {
	if len(list1) <= 0 || len(list2) <= 0 {
		return
	}
	if list1[0] == list2[0] {
		return append(lcs(list1[1:], list2[1:]), list1[0])
	}
	return longest(lcs(list1, list2[1:]), lcs(list1[1:], list2))
}

func longest(list1 []int, list2 []int) []int {
	if len(list1) > len(list2) {
		return list1
	}
	return list2
}

func reverse(list []int) (reversed []int) {
	for i := len(list) - 1; i >= 0; i-- {
		reversed = append(reversed, list[i])
	}
	return
}

func exitWithError() {
	fmt.Println("Usage: please pass to lists to produce the lcs. For example: \"1, 4, 5, 3, 15, 6\" \"1, 7, 4, 5, 11, 6\"")
	os.Exit(1)
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

func main() {
	if len(os.Args) != 3 {
		exitWithError()
	}

	list1 := strToSliceInt(os.Args[1])
	list2 := strToSliceInt(os.Args[2])
	fmt.Println(reverse(lcs(list1, list2)))
}
