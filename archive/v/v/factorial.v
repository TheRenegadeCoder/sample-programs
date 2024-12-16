module main

import os
import strconv

fn factorial(n u64) u64 {
	return match true {
		n <= 0 { 0 }
		n <= 1 { 1 }
		else { n * factorial(n-1) }
	}
}

fn main() {
	if os.args.len != 2 {
		println("Usage: please input a non-negative integer")
		exit(1)
	}

	n := strconv.atoi(os.args[1]) or {
		println("Usage: please input a non-negative integer")
		exit(1)
	}
	println(factorial(u64(n)))
}
