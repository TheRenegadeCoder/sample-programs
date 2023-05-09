use std::env::args;
use std::process::exit;
use std::str::FromStr;
use std::fmt::Display;

fn usage() -> ! {
    println!("Usage: please input a non-negative integer");
    exit(0);
}

fn parse_int<T: FromStr>(s: &str) -> Result<T, <T as FromStr>::Err> {
    s.trim().parse::<T>()
}

fn is_palindromic_number<T: Display>(n: T) -> bool {
    // Source: https://stackoverflow.com/questions/24542115/how-to-index-a-string-in-rust

    // Convert number to string
    let s: String = n.to_string();

    // Check if palindrome by comparing left half of string with reversed right half of string
    let half_s_len: usize = s.len() / 2;
    s.chars().take(half_s_len).eq(s.chars().rev().take(half_s_len))
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to integer
    let n: u32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Determine if palindromic number and display result
    println!("{}", is_palindromic_number::<u32>(n));
}
