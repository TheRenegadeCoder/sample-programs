use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!(
        "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"
    );
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

fn linear_search(arr: &Vec<i32>, target: i32) -> Option<usize> {
    arr.into_iter().position(|&x| x == target)
}

fn main() {
    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = parse_int_list(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to integer
    let target: i32 = parse_int(
        args().nth(2)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    // Do linear search and display result
    let result: bool = match linear_search(&arr, target) {
        Some(_) => true,
        None => false,
    };
    println!("{result}");
}
