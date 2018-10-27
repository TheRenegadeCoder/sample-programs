/**
	
MIT License

Copyright (c) 2018 Víctor Fernández <vfrico@google-mail-com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

/*
	Sample program to test mutable arrays pointers in rust
*/

fn fibonacci_cache(n: usize, cache: &mut [u128]) -> u128 {
	let val: u128 = cache[n];
	if val == 0 {
		cache[n] = fibonacci_cache(n-1, cache) + fibonacci_cache(n-2, cache);
	}
	return cache[n];
}

fn main() {
	let mut fibs: [u128; 200] = [0;200];
	fibs[0] = 1;
	fibs[1] = 1;

	let mut uinput = String::new();
    let mut uinput_n: usize = 0;

    println!("Enter n number to compute fib(n) and press enter");
    if std::io::stdin().read_line(&mut uinput).is_err() {
        println!("Could not read from keyboard!");
    } else {
        uinput.pop();
        uinput_n = uinput.parse().unwrap();
	}

	if uinput_n > 185 {
		println!("Unable to compute such a large number. Rust only can hold a number less than {}", u128::max_value());
	} else {
		println!("Fib({}) = {}", uinput_n,  fibonacci_cache(uinput_n, &mut fibs));	
	}

}
