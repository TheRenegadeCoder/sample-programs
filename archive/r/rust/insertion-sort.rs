use std::env;
use std::process;

fn usage() {
    println!("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
    process::exit(0);
}

fn parse_int(s: &String) -> Option<i32> {
    match s.trim().parse::<i32>() {
        Ok(n) => Some(n),
        Err(e) => None,
    }
}

fn parse_int_list(s_list: &String) -> Vec<i32> {
    let results: Vec<Option<i32>> = s_list.split(",")
        .map(|s| parse_int(&s.to_string()))
        .collect();
    if results.iter().any(|s| s.is_none()) {
        vec![]
    }
    else {
        results.iter().map(|result| result.unwrap()).collect()
    }
}


fn insertion_sort(arr: &mut Vec<i32>) {
    for i in 0..arr.len() {
        for j in (0..i).rev() {
            if arr[j] >= arr[j+1] {
                arr.swap(j, j+1);
            } else {
                break;
            }
        }
    }
}

fn main() {
    // Exit if not enough command-line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        usage();
    }

    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = parse_int_list(&args[1]);

    // Exit if list too small
    if arr.len() < 2 {
        usage();
    }

    insertion_sort(&mut arr);
    println!("{:?}", arr);
}
