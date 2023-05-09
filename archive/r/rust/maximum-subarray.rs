use std::env::args;
use std::process::exit;
use std::str::FromStr;
use std::cmp::max;

fn usage() -> ! {
    println!("Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\"");
    exit(0);
}

fn parse_int<T: FromStr>(s: &str) -> Result<T, <T as FromStr>::Err> {
    s.trim().parse::<T>()
}

fn parse_int_list<T: FromStr>(s: &str) -> Result<Vec<T>, <T as FromStr>::Err> {
    s.split(',')
        .map(parse_int)
        .collect::<Result<Vec<T>, <T as FromStr>::Err>>()
}

// Find maximum subarray using Kadane's algorithm.
// Source: https://en.wikipedia.org/wiki/Maximum_subarray_problem#No_empty_subarrays_admitted
fn maximum_subarray(arr: &Vec<i32>) -> i32 {
    let mut best_sum: i32 = i32::MIN;
    let mut current_sum: i32 = 0;
    for value in arr {
        current_sum = value + max(0, current_sum);
        best_sum = max(current_sum, best_sum);
    }

    best_sum
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Get maximum subarray and display
    println!("{}", maximum_subarray(&arr));
}
