use std::env::args;
use std::process::exit;
use std::num::ParseIntError;
use std::thread;
use std::time::Duration;
use std::sync::{Arc, Mutex};

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
        ),
    }
}

fn sleep_sort(arr: &mut Vec<i32>) {
    // Start sleep threads that sleep for specified time and append that time to result
    let mut threads = vec![];
    let result_mutex = Arc::new(Mutex::new(vec![]));
    for sleep_time in arr.clone() {
        let result_mutex_clone = Arc::clone(&result_mutex);
        let value = sleep_time.clone();
        threads.push(
            thread::spawn(move || {
                thread::sleep(Duration::from_secs(value as u64));
                result_mutex_clone.lock().unwrap().push(value);
            })
        )
    }

    // Wait for threads to finish
    for thread in threads {
        thread.join().unwrap();
    }

    // Store result
    *arr = result_mutex.lock().unwrap().to_vec();
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

    sleep_sort(&mut arr);
    println!("{:?}", arr);
}
