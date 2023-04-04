use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
    exit(0);
}

fn parse_int(s: String) -> Result<i32, ParseIntError> {
    s.trim().parse::<i32>()
}

fn parse_int_list(s_list: String) -> Vec<i32> {
    let results: Vec<Result<i32, ParseIntError>> = s_list.split(",")
        .map(|s| parse_int(s.to_string()))
        .collect();
    match results.iter().any(|s| s.is_err()) {
        true => vec![],
        false => results.iter()
            .map(|result| result.clone().unwrap())
            .collect()
    }
}

fn bubble_sort(arr: &mut Vec<i32>) {
    let mut swap_occured = true;

    while swap_occured {
        swap_occured = false;

        for i in 1..arr.len() {
            if arr[i - 1] > arr[i] {
                arr.swap(i - 1, i);
                swap_occured = true;
            }
        }
    }
}

fn main() {
    let mut args = args();
    args.next(); // Skip command name

    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = parse_int_list(
        args.next()
        .unwrap_or_else(|| usage())
    );

    // Exit if list too small
    if arr.len() < 2 {
        usage();
    }

    // Perform bubble sort and show results
    bubble_sort(&mut arr);
    println!("{:?}", arr);
}
