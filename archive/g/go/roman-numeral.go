package main

import "fmt"
import "os"

func main () {
	var numerals = map[string]int {
		"I": 1,
		"V": 5,
		"X": 10,
		"L": 50,
		"C": 100,
		"D": 500,
		"M": 1000,
	}
	var input string
	var i int = 0
	var temp1 int
	var temp2 int
	var total int = 0

	//Args or die
	if len(os.Args) != 2 {
		usageandexit(os.Args[0], 0)
	}

	input = os.Args[1]

	//While i is within bounds of input
	for i < len(input) {
		//Get the current value
		temp1 = numerals[string(input[i])]
		if temp1 == 0 {
			usageandexit(os.Args[0], 1)
		}

		//If we still have input left to compare, check if we need to
		//	subtract from the next value
		if len(input) > i + 1 {
			//Get the next value
			temp2 = numerals[string(input[i+1])]
			if temp2 == 0 {
				usageandexit(os.Args[0], 1)
			}

			//If the current value is >= next, use it's mapped value
			if temp1 >= temp2 {
				total += temp1
				i++
			//Otherwise, adjust for the subtraction and skip next
			} else {
				total += temp2 - temp1
				i += 2
			}
		//Otherwise, just add the current value to the total
		} else {
			total += temp1
			i++
		}
	}

	fmt.Printf("%d\n", total)
}

func usageandexit (name string, code int) {
	fmt.Printf("Usage: %s [roman numeral]\n", name)
	os.Exit(code)
}
