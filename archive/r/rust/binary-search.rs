use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")");
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

fn is_sorted(arr: &Vec<i32>) -> bool {
    let mut is_sorted = true;
    for i in 0..(arr.len() - 1) {
        if arr[i] > arr[i + 1] {
            is_sorted = false;
            break;
        }
    }

    is_sorted
}

fn binary_search(search_arr: &Vec<i32>, target: &i32) -> Option<usize> {
    let mut low: usize = 0;
    let mut high: usize = search_arr.len() - 1;

    while low <= high {
        let mid = (((high - low) / 2) + low);
        let val = &search_arr[mid];

        if val == target {
            return Some(mid);
        }

        // If value is < target then search between mid + 1 and high
        if val < target {
            low = mid + 1;
        }

        // If value is > target then search between low and mid - 1
        if val > target {
            high = mid - 1;
        }
    }

    return None;
}

fn main() {
    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = parse_int_list(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Make sure array is sorted
    if !is_sorted(&arr) {
        usage();
    }

    // Convert 2nd command-line argument to integer
    let target: i32 = parse_int(
        args().nth(2)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    match binary_search(&arr, &target) {
        Some(_) => println!("true"),
        None => println!("false"),
    }
}
