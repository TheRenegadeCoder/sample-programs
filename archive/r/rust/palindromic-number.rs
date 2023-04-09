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

fn is_palindromic_number(n: i32) -> bool {
    // Source: https://stackoverflow.com/questions/24542115/how-to-index-a-string-in-rust

    // Convert number to string
    let s: String = n.to_string();

    // Check if palindrome by comparing left half of string with reversed right half of string
    let half_s_len: usize = s.len() / 2;
    s.chars().take(half_s_len).eq(s.chars().rev().take(half_s_len))
}

fn main() {
    // Convert 1st command-line argument to integer
    let n: i32 = parse_int(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    // Check if negative
    if n < 0 {
        usage();
    }

    // Determine if palindromic number and display result
    println!("{}", is_palindromic_number(n));
}
