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

fn merge(lhs: &Vec<i32>, rhs: &Vec<i32>, merged_arr: &mut Vec<i32>) {
    let mut lhs_idx = 0;
    let mut rhs_idx = 0;
    let mut merged_idx = 0;

    while lhs_idx < lhs.len() && rhs_idx < rhs.len() {
        if lhs[lhs_idx] < rhs[rhs_idx] {
            merged_arr[merged_idx] = lhs[lhs_idx];
            lhs_idx += 1;
        } else {
            merged_arr[merged_idx] = rhs[rhs_idx];
            rhs_idx += 1;
        }

        merged_idx += 1;
    }

    if lhs_idx < lhs.len() {
        merged_arr[merged_idx..].copy_from_slice(&lhs[lhs_idx..]);
    }
    else if rhs_idx < rhs.len() {
        merged_arr[merged_idx..].copy_from_slice(&rhs[rhs_idx..]);
    }
}

fn merge_sort(arr: &mut Vec<i32>) {
    if arr.len() <= 1 {
        return;
    }

    let mid = arr.len() / 2;
    let mut lhs = arr[..mid].to_vec();
    let mut rhs = arr[mid..].to_vec();

    merge_sort(&mut lhs);
    merge_sort(&mut rhs);

    merge(&lhs, &rhs, arr);
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

    merge_sort(&mut arr);
    println!("{:?}", arr);
}
