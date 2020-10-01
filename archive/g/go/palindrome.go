package main

import "fmt"

func isPalindrome(input string) bool {
	for i := 0; i < len(input)/2; i++ {
		if input[i] != input[len(input)-i-1] {
			return false
		}
	}
	return true
}

func main() {
	input := "radar"
	isPalindrome := isPalindrome(input)

	if isPalindrome {
		fmt.Println("string is palindrome")
	} else {
		fmt.Println("string is not palindrome")
	}
}
