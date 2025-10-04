use std::env::args;
use std::process::exit;
use std::str::FromStr;

fn usage() -> ! {
    println!("Usage: please input the total number of people and number of people to skip.");
    exit(0);
}

fn parse_int<T: FromStr>(s: &str) -> Result<T, <T as FromStr>::Err> {
    s.trim().parse::<T>()
}

// Reference: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case
//
// Use zero-based index algorithm:
//
//    g(1, k) = 0
//    g(m, k) = [g(m - 1, k) + k] MOD m, for m = 2, 3, ..., n
//
// Final answer is g(n, k) + 1 to get back to one-based index
fn josephus(n: i32, k: i32) -> i32 {
    let mut g: i32 = 0;
    for m in 2..=n {
        g = (g + k) % m;
    }

    g + 1
}

fn main() {
    let mut args = args().skip(1);

    // Exit if 1st command-line argument not an integer
    let mut n: i32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Exit if 2nd command-line argument not an integer
    let mut k: i32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Run Josephus problem and store results
    println!("{}", josephus(n, k));
}
