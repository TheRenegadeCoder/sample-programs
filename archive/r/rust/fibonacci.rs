use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

const LIMIT: i32 = 93;

fn usage() -> ! {
    println!("Usage: please input the count of fibonacci numbers to output");
    exit(0);
}

fn parse_int(s: String) -> Result<i32, ParseIntError> {
    s.trim().parse::<i32>()
}

fn fibonacci(terms: i32) {
    if terms > LIMIT {
        println!("The number of terms you want to calculate is too big!");
        println!("The limit is {}.", LIMIT);
    } else {
        let mut a = 0u64;
        let mut b = 1u64;
        let mut c = 0u64;
        for i in 1..(terms + 1) {
            c = a + b;
            b = a;
            a = c;

            println!("{i}: {c}");
        }
    }
}

fn main() {
    let mut args = args();
    args.next(); // Skip command name

    // Exit if 1st command-line argument not an integer
    let mut input_value: Result<i32, ParseIntError> = parse_int(
        args.next().unwrap_or_else(|| usage())
    );
    if input_value.is_err() {
        usage();
    }

    let input_num: i32 = input_value.unwrap();

    // Show request number of Fibonacci numbers
    fibonacci(input_num);
}
