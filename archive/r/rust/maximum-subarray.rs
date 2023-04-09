use std::env::args;
use std::process::exit;
use std::num::ParseIntError;
use std::cmp::max;

fn usage() -> ! {
    println!("Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\"");
    exit(0);
}

fn parse_int(s: String) -> Result<i32, ParseIntError> {
    s.trim().parse::<i32>()
}

fn parse_int_list(s_list: String) -> Option<Vec<i32>> {
    let results: Vec<Result<i32, ParseIntError>> = s_list.split(",")
        .map(|s| parse_int(s.to_string()))
        .collect();
    match results.iter().any(|s| s.is_err()) {
        true => None,
        false => Some(
            results.iter()
            .map(|result| result.clone().unwrap())
            .collect()
        ),
    }
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
    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = parse_int_list(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Get maximum subarray and display
    println!("{}", maximum_subarray(&arr));
}
