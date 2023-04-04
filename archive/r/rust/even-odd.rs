// Requirement is in https://sample-programs.therenegadecoder.com/projects/even-odd/
// Program to accept an integer on the command line and outputs if the integer is Even or Odd.

use std::env;

fn usage() {
    println!("Usage: please input a number");
    std::process::exit(0);
}

fn parse_int(s: &String) -> Option<i32> {
    match s.trim().parse::<i32>() {
        Ok(n) => Some(n),
        Err(e) => None,
    }
}

fn main() {
    // Exit if not enough command-line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        usage();
    }

    // Exit if 1st command-line argument not an integer
    let mut input_value: Option<i32> = parse_int(&args[1]);
    if input_value.is_none() {
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
