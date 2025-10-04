module main

import os

fn main() {
	if os.args.len == 2 {
		println(os.args[1].reverse())
	}
}
