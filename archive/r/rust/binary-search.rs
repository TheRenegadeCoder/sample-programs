use std::env::args;
use std::process::exit;
use std::str::FromStr;

fn usage() -> ! {
    println!("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")");
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

fn is_sorted<T: PartialOrd>(arr: &Vec<T>) -> bool {
    (0..(arr.len() - 1))
        .all(|x| arr[x] <= arr[x + 1])
}

fn binary_search<T: PartialOrd + PartialEq>(search_arr: &Vec<T>, target: &T) -> Option<usize> {
    let mut low: usize = 0;
    let mut high: usize = search_arr.len() - 1;

    while low <= high {
        let mid = ((high - low) / 2) + low;
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
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let arr: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Make sure array is sorted
    if !is_sorted(&arr) {
        usage();
    }

    // Convert 2nd command-line argument to integer
    let target: i32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    match binary_search::<i32>(&arr, &target) {
        Some(_) => println!("true"),
        None => println!("false"),
    }
}
