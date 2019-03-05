package main

import (
	"encoding/json"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func bubbleSort(list []int) []int {
	swapped := true
	for swapped {
		swapped = false
		for i := 0; i < len(list)-1; i++ {
			if list[i] > list[i+1] {
				n := list[i]
				list[i] = list[i+1]
				list[i+1] = n
				swapped = true
			}
		}
	}
	return list
}

func swap(list []int, firstIndex int, secondIndex int) bool {
	if list[firstIndex] > list[secondIndex] {
		x := list[firstIndex]
		list[firstIndex] = list[secondIndex]
		list[secondIndex] = x
		return true
	}
	return false
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
	if len(sNums) <= 2 {
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
	nums = bubbleSort(nums)
	str, _ := json.Marshal(nums)

	fmt.Println(strings.Trim(string(str), "[]"))
}
