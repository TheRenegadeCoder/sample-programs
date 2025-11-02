import os

fn show_error() {
	println('Usage: please provide a string')
}

fn main() {
	args := os.args[1..] // skip program name
	if args.len == 0 {
		show_error()
		return
	}
	input_str := args[0]
	if input_str.len == 0 {
		show_error()
		return
	}

	mut counts := map[rune]int{}
	for c in input_str.runes() {
		counts[c]++
	}

	mut found := false
	for c in input_str.runes() {
		if counts[c] > 1 {
			println('${c.str()}: ${counts[c]}')
			counts[c] = 0 // prevent duplicate printing
			found = true
		}
	}

	if !found {
		println('No duplicate characters')
	}
}
