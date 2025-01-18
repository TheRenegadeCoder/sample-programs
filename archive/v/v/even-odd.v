module main

import os
import strconv

fn main() {
	if os.args.len < 2 {
		println('Usage: please input a number')
		exit(1)
	}

	num := strconv.atoi(os.args[1]) or {
		println('Usage: please input a number')
		exit(1)
	}

	print(match num % 2 {
		0 { 'Even' }
		1, -1 { 'Odd' }
		else { 'Usage: please input a number' }
	})
}
