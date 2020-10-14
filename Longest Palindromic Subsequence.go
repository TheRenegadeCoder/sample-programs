// Longest Palindromic Subsequence
// DP solution using O(n^2) time complexity and O(n^2) space complexity

package main

import (
	"fmt"
	"unicode"
)

func longestPalindrome(s string) string {
	if len(s) == 0 {
		return "Incorrect input provided. Program Terminated"
	}

	start, n, maxLen := 0, len(s), 0
	d := make([][]bool, n)
	for i := 0; i < n; i++ {
		d[i] = make([]bool, n)
	}

	for i := n - 1; i >= 0; i-- {
		for j := i; j < n; j++ {
			if i == j {
				d[i][j] = truepackage main

import (
	"fmt"
	"unicode"
)

func longestPalindrome(s string) string {
	if len(s) == 0 {
		return "Incorrect input provided. Program Terminated"
	}

	start, n, maxLen := 0, len(s), 0
	d := make([][]bool, n)
	for i := 0; i < n; i++ {
		d[i] = make([]bool, n)
	}

	for i := n - 1; i >= 0; i-- {
		for j := i; j < n; j++ {
			if i == j {
				d[i][j] = true
			} else if i+1 == j {
				d[i][j] = s[i] == s[j]
			} else {
				d[i][j] = s[i] == s[j] && d[i+1][j-1]
			}

			if d[i][j] && (j-i+1) > maxLen {
				start = i
				maxLen = j - i + 1
			}
		}
	}

	return s[start : start+maxLen]


}

func IsUpper(s string) bool {
	for _, r := range s {
		if !unicode.IsUpper(r) && unicode.IsLetter(r) {
			return false
		}
	}
	return true
}

func IsLower(s string) bool {
	for _, r := range s {
		if !unicode.IsLower(r) && unicode.IsLetter(r) {
			return false
		}
	}
	return true
}

func main() {
	s:="cbbd"
	if IsUpper(s) || IsLower(s){
		fmt.Println(longestPalindrome(s))
	}else{
		fmt.Println("No Palindromic substring present.")
	}
	
}
			} else if i+1 == j {
				d[i][j] = s[i] == s[j]
			} else {
				d[i][j] = s[i] == s[j] && d[i+1][j-1]
			}

			if d[i][j] && (j-i+1) > maxLen {
				start = i
				maxLen = j - i + 1
			}
		}
	}

	return s[start : start+maxLen]


}

func IsUpper(s string) bool {
	for _, r := range s {
		if !unicode.IsUpper(r) && unicode.IsLetter(r) {
			return false
		}
	}
	return true
}

func IsLower(s string) bool {
	for _, r := range s {
		if !unicode.IsLower(r) && unicode.IsLetter(r) {
			return false
		}
	}
	return true
}

func main() {
	s:="cbbd"
	if IsUpper(s) || IsLower(s){
		fmt.Println(longestPalindrome(s))
	}else{
		fmt.Println("No Palindromic substring present.")
	}
	
}
