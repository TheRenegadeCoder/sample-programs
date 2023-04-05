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
        )
    }
}

fn selection_sort(arr: &mut Vec<i32>) {
    // Source: https://en.wikipedia.org/wiki/Selection_sort#Implementations
    for i in 0..(arr.len() - 1) {
        let mut min_pos = i;
        for j in (i + 1)..arr.len() {
            if arr[j] < arr[min_pos] {
                min_pos = j;
            }
        }

        if min_pos != i {
            arr.swap(min_pos, i);
        }
    }
}

fn main() {
    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = parse_int_list(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Exit if list too small
    if arr.len() < 2 {
        usage();
    }

    selection_sort(&mut arr);
    println!("{:?}", arr);
}
