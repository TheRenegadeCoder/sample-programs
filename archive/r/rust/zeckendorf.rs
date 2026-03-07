use std::cmp::PartialOrd;
use std::env::args;
use std::ops::{Add, SubAssign};
use std::process::exit;
use std::str::FromStr;

fn usage() -> ! {
    println!("Usage: please input a non-negative integer");
    exit(0);
}

fn parse_int<T: FromStr>(s: &str) -> Result<T, <T as FromStr>::Err> {
    s.trim().parse::<T>()
}

fn get_fibonacci_values<T>(value: T) -> Vec<T> 
where 
    T: Add<Output = T> + PartialOrd + From<u8> + Copy 
{
    let mut fibs = vec![];
    let mut a: T = T::from(1);
    let mut b: T = T::from(2);
    while a <= value {
        fibs.push(a);
        (a, b) = (b, a + b);
    }

    fibs
}

fn get_zeckendorf_values<T>(value: T) -> Vec<T>
where 
    T: Add<Output = T> + SubAssign + PartialOrd + From<u8> + Copy 
{
    let fibs = get_fibonacci_values(value);
    let mut zecks = vec![];
    let mut n = (fibs.len() as i32) - 1;
    let mut remaining = value;
    while n >= 0 && remaining > T::from(0) {
        let f = fibs[n as usize];
        if remaining >= f {
            zecks.push(f);
            remaining -= f;
            n -= 2;
        } else {
            n -= 1;
        }
    }

    zecks
}

fn main() {
    let mut args = args().skip(1);

    // Exit if 1st command-line argument not an integer
    let input_num: i32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Exit if value is negative
    if input_num < 0 {
        usage();
    }

    let zecks = get_zeckendorf_values::<i32>(input_num);
    println!("{:?}", zecks);
}
