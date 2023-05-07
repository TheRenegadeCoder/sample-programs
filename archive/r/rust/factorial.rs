//  Requirement     https://sample-programs.therenegadecoder.com/projects/factorial/
// Accept a number on command line and print it's factorial
// Works till factorial 34, which is 39 digits, ...
use std::env::args;
use std::process::exit;
use std::str::FromStr;

fn usage() -> ! {
    println!("Usage: please input a non-negative integer");
    exit(0);
}

fn parse_int<T: FromStr>(s: &str) -> Result<T, <T as FromStr>::Err> {
    s.trim().parse::<T>()
}

fn main() {
    let mut args = args().skip(1);

    // confirm positive integer is passed as command-line argument
    let mut input_num: u32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    let mut n = input_num as u128;
    let mut result = 1;
    while n > 0 {
        result *= n;
        n -= 1;
    }
    println!("{result}");
}
