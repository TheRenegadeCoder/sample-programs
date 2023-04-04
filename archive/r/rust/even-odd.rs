// Requirement is in https://sample-programs.therenegadecoder.com/projects/even-odd/
// Program to accept an integer on the command line and outputs if the integer is Even or Odd.

use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!("Usage: please input a number");
    exit(0);
}

fn parse_int(s: String) -> Result<i32, ParseIntError> {
    s.trim().parse::<i32>()
}

fn main() {
    // Exit if 1st command-line argument not an integer
    let mut input_value: Result<i32, ParseIntError> = parse_int(
        args().nth(1).unwrap_or_else(|| usage())
    );
    if input_value.is_err() {
        usage();
    }

    let input_num: i32 = input_value.unwrap();

    // Even numbers are divisible by 2
    if input_num % 2 == 0 {
        println!("Even");
    }
    // Odd numbers are not divisible by 2
    else {
        println!("Odd");
    }
}
