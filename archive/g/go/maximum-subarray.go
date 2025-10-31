package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Please enter a list of comma-separated numbers")
	}
	input := os.Args[1]
	parts := strings.Split(input, ",")
	nums := make([]int, len(parts))

	for i, p := range parts {
		n, _ := strconv.Atoi(p)
		nums[i] = n

	}

	maxSum := nums[0]
	blockSum := nums[0]

	for i := 0; i < len(nums); i++ {
		blockSum = max(nums[i], blockSum+nums[i])
		if maxSum < blockSum {
			maxSum = blockSum

		}
		fmt.Println(blockSum, maxSum)
	}

}
