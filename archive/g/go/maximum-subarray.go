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
	if len(os.Args) < 2 || strings.TrimSpace(os.Args[1]) == "" {
		fmt.Println(`Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"`)
		return
	}
	input := strings.Join(os.Args[1:], "")
	parts := strings.Split(input, ",")
	nums := make([]int, len(parts))

	for i, p := range parts {
		p = strings.TrimSpace(p)
		n, _ := strconv.Atoi(p)
		nums[i] = n

	}

	maxSum := nums[0]
	blockSum := nums[0]

	for i := 1; i < len(nums); i++ {
		blockSum = max(nums[i], blockSum+nums[i])
		if maxSum < blockSum {
			maxSum = blockSum

		}

	}
	fmt.Println(maxSum)

}
