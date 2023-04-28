package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

// Time to mutiply each number by when sleeping
// 15ms is hopefully a happy middle ground between flaky and slow sorting
const sleepFactor = 15 * time.Millisecond
const errorMessage = `Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"`

// Parses string of comma-space separated integers into slice of ints
// Returns non-nil error if numbers are malformed or if there are fewer than 2 numbers
func parseInput(input string) ([]int, error) {
	splitInput := strings.Split(input, ", ")
	if len(splitInput) < 2 {
		return nil, fmt.Errorf("Input '%s' does not contain at least two numbers", splitInput)
	}

	nums := make([]int, len(splitInput))
	for i, s := range splitInput {
		n, err := strconv.Atoi(s)
		if err != nil {
			return nil, err
		}
		nums[i] = n
	}
	return nums, nil
}

// Sends the given number to the given channel after the given amount of time
// Blocks the current goroutine until send is completed
func waitAndSend(num int, wait time.Duration, c chan int) {
	time.Sleep(wait)
	c <- num
}

// Finds the minimum int in a slice.
// Panics on an empty slice
func minInt(nums []int) int {
	min := nums[0]
	for _, n := range nums {
		if n < min {
			min = n
		}
	}
	return min
}

// Creates a new sorted slice of ints from the input
// Internally makes len(unsorted) goroutines
func sleepSort(unsorted []int) []int {
	min := minInt(unsorted)

	c := make(chan int)
	for _, n := range unsorted {
		// Shift the numbers by the minimum value and multiply by the sleepFactor
		// This means the smallest number will have no sleep
		// This is necessary to accomodate negative numbers as you can't sleep
		// for a negative amount of time.
		// If all numbers are positive, it reduces the runtime by about min * sleepFactor
		sleepTime := time.Duration(n-min) * sleepFactor

		go waitAndSend(n, sleepTime, c)
	}

	sorted := make([]int, len(unsorted))
	for i := range unsorted {
		sorted[i] = <-c
	}

	return sorted
}

// Join a slice of ints into a comma-space separated string
func formatSlice(nums []int) string {
	strs := make([]string, len(nums))

	for i, n := range nums {
		strs[i] = strconv.Itoa(n)
	}

	return strings.Join(strs, ", ")
}

// Takes a string of comma-space separated integers and returns
// a new comma-space separated string with the values in ascending order.
func parseAndSort(input string) (string, error) {
	unsorted, err := parseInput(input)
	if err != nil {
		return "", err
	}

	sorted := sleepSort(unsorted)
	return formatSlice(sorted), nil
}

func main() {
	// Must supply an argument
	if len(os.Args) < 2 {
		fmt.Println(errorMessage)
		os.Exit(1)
	}

	output, err := parseAndSort(os.Args[1])
	if err != nil {
		fmt.Println(errorMessage)
		os.Exit(1)
	} else {
		fmt.Println(output)
	}
}
