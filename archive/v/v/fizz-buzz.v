module main

fn main() {
	for i in 1..101 {
		println(match true {
			i % 15 == 0 { "FizzBuzz" }
			i % 5 == 0 { "Buzz" }
			i % 3 == 0 { "Fizz" }
			else { i.str() }
		})
	}
}
