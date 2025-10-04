package main

import "core:fmt"

main :: proc() {
	for i in 1..=100 {
		if i % 15 == 0 {
			fmt.println("FizzBuzz")
		} else if i % 5 == 0 {
			fmt.println("Buzz")
		} else if i % 3 == 0 {
			fmt.println("Fizz")
		} else {
			fmt.println(i)
		}
	}
}
