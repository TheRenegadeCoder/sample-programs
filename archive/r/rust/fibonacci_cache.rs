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
