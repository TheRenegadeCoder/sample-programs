use std::env::args;
use std::process::exit;
use std::str::FromStr;

fn usage() -> ! {
    println!(
        "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"
    );
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

fn linear_search<T: PartialEq>(arr: &Vec<T>, target: &T) -> Option<usize> {
    arr.into_iter().position(|x| x == target)
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let arr: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to integer
    let target: i32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Do linear search and display result
    let result: bool = match linear_search::<i32>(&arr, &target) {
        Some(_) => true,
        None => false,
    };
    println!("{result}");
}
