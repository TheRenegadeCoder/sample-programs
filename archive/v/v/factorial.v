module main

import os
import strconv

fn factorial(n u64) u64 {
	return match true {
		n <= 1 { 1 }
		else { n * factorial(n-1) }
	}
}

fn usage() {
	println("Usage: please input a non-negative integer")
	exit(1)
}

fn main() {
	if os.args.len != 2 {
		usage()
	}

	n := strconv.atoi(os.args[1]) or {
		usage()
		exit(1)
	}
	if n < 0 {
		usage()
	}
	println(factorial(u64(n)))
}
