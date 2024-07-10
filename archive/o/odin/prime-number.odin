package main


import "core:fmt"
import "core:math"
import "core:os"
import "core:strconv"

is_prime :: proc(n: i64) -> bool {
	if n <= 1 {
		return false
	}
	if n == 2 {
		return true
	}
	for i in 2..=i64(math.sqrt(f32(n)) + 1) {
		if n % i == 0 {
			return false
		}
	}
	return true
}

usage :: proc() {
	fmt.eprintln("Usage: please input a non-negative integer")
}

prime_numbers :: proc(args : []string) {
    n: i64
    ok: bool
	// Get command line argument as string
	args := os.args
	if len(args) < 2 {
		usage()
		return
	}
    if n, ok = strconv.parse_i64(args[1]) ; !ok {
        usage()
		return
    }
	if n < 0  || n % 1 != 0 {
		usage()
		return
	}
	
	if is_prime(n) {
		fmt.println("prime")
	} else {
		fmt.println("composite")
	}
}

main :: proc() {
    prime_numbers(os.args)
}
