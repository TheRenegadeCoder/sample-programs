module main

import os

fn main() {
	if os.args.len < 2 {
		eprintln('Usage: please input a number')
		exit(1)
	}

	print(match os.args[1].i64() % 2 {
		i64(0) { 'Even' }
		i64(1) { 'Odd' }
		else { 'Usage: please input a number' }
	})
}
