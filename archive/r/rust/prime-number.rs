//  Requirement     https://sample-programs.therenegadecoder.com/projects/prime-number/
// Accept a number on command line and print if it is Composite or Prime 
// Works till  39 digits, ...

use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!("Usage: please input a non-negative integer");
    exit(0);
}

fn parse_int(s: String) -> Result<i128, ParseIntError> {
    s.trim().parse::<i128>()
}

fn main() {
    // Exit if 1st command-line argument not an integer
    let mut input_value: Result<i128, ParseIntError> = parse_int(
        args().nth(1).unwrap_or_else(|| usage())
    );
    if input_value.is_err() {
        usage();
    }

    // Exit if negative integer
    let input_num: i128 = input_value.unwrap();
    if input_num < 0 {
        usage();
    }

    let mut n = 3 as u128;
    let value = input_num as u128;

    if value < 2 || (value != 2 && value % 2 == 0) {
        println!("Composite");
        exit(0);
    }
    while n * n <= value {
        if value % n == 0 {
            println!("Composite");
            exit(0);
        }
        n = n + 2;
    }
    println!("Prime");
}
