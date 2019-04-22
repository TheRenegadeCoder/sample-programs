package main

import "fmt"
import "os"

func exitWithError(msg string) {
	fmt.Println(msg)
	os.Exit(1)
}

func toRoman(input string) (total int) {
	var i = 0
	var temp1 int
	var temp2 int

	var numerals = map[string]int{
		"I": 1,
		"V": 5,
		"X": 10,
		"L": 50,
		"C": 100,
		"D": 500,
		"M": 1000,
	}

	//While i is within bounds of input
	for i < len(input) {
		//Get the current value
		temp1 = numerals[string(input[i])]
		if temp1 == 0 {
			exitWithError("Error: invalid string of roman numerals")
		}

		//If we still have input left to compare, check if we need to
		//	subtract from the next value
		if len(input) > i+1 {
			//Get the next value
			temp2 = numerals[string(input[i+1])]
			if temp2 == 0 {
				exitWithError("Error: invalid string of roman numerals")
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
	return
}

func main() {
	//Args or die
	if len(os.Args) != 2 {
		exitWithError("Usage: please provide a string of roman numerals")
	}

	roman := toRoman(os.Args[1])
	fmt.Printf("%d\n", roman)
}
