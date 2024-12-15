module main

import os

fn main() {
	if os.args.len < 2 {
		eprintln('usage: please put a number as an argument, eg')
		eprintln('even-odd 95')
		exit(1)
	}

	print(match os.args[1].int() % 2 {
		0 { 'Even' }
		1 { 'Odd' }
		else { 'Please enter an integer.' }
	})
}
