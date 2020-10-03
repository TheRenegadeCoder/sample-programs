package main

import "fmt"

func longestPalSubstr(str string) string {
	maxLength := 1
	start := 1
	result := ""

	if len(str) < 2 || str == "" {
		return "Incorrect input provided. Program Terminated"
	}

	for i := 0; i < len(str); i++ {
		for j := i; j < len(str); j++ {
			flag := true

			// check palindrome
			for k := 0; k < (j-i+1)/2; k++ {
				if str[i + k] != str[j - k] {
					flag = false
				}
			}

			// palindrome
			if flag && (j - i + 1) > maxLength {
				start = i
				maxLength = j - i + 1
			}
		}
	}

	p := printSubStr(str, start, start + maxLength - 1)
	if len(p) > 0 {
		result = fmt.Sprintf("Longest Palindromic Substring is: %s", p)
	} else {
		result = "No Palindromic substring present."
	}
	return result
}

func printSubStr(str string, low, high int) string {
	s := ""
	for i := low; i <= high; i++ {
		s = s + string(str[i])
	}

	return s
}

func main() {
	str := "paapaapap";
	res := longestPalSubstr(str)
	fmt.Println(res)
}
