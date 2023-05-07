use std::env::args;
use std::process::exit;
use std::str::FromStr;

fn usage() -> ! {
    println!("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
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

fn selection_sort<T: PartialOrd>(arr: &mut Vec<T>) {
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
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Exit if list too small
    if arr.len() < 2 {
        usage();
    }

    selection_sort::<i32>(&mut arr);
    println!("{arr:?}");
}
