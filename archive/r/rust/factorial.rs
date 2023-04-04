//  Requirement     https://sample-programs.therenegadecoder.com/projects/factorial/
// Accept a number on command line and print it's factorial
// Works till factorial 34, which is 39 digits, ...
use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!("Usage: please input a non-negative integer");
    exit(0);
}

fn parse_int(s: String) -> Result<i32, ParseIntError> {
    s.trim().parse::<i32>()
}

fn main() {
    // confirm integer is passed as commandline argument
    let mut input_value: Result<i32, ParseIntError> = parse_int(
        args().nth(1).unwrap_or_else(|| usage())
    );
    if input_value.is_err() {
        usage();
    }

    // confirm non-negative integer
    let input_num: i32 = input_value.unwrap();
    if input_num < 0 {
        usage();
    }

    let mut n = input_num as u128;
    let mut result = 1;
    while n > 0 {
        result = result * n;
        n = n - 1;
    }
    println!("{}", result );
}
