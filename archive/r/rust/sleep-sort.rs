use std::env::args;
use std::process::exit;
use std::str::FromStr;
use std::thread;
use std::time::Duration;
use std::sync::{Arc, Mutex};

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

    sleep_sort(&mut arr);
    println!("{arr:?}");
}
