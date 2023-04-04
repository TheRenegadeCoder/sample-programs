use std::env;
use std::process;

const LIMIT: i32 = 93;

fn usage() {
    println!("Usage: please input the count of fibonacci numbers to output");
    process::exit(0);
}

fn parse_int(s: &String) -> Option<i32> {
    match s.trim().parse::<i32>() {
        Ok(n) => Some(n),
        Err(e) => None,
    }
}

fn fibonacci(terms: i32) {
    if terms > LIMIT {
        println!("The number of terms you want to calculate is too big!");
        println!("The limit is {}.", LIMIT);
    } else {
        let mut i = 0i32;
        let mut a = 0u64;
        let mut b = 1u64;
        let mut c = 0u64;
        while i < terms {
            c = a + b;
            b = a;
            a = c;
            
            i += 1;
            println!("{}: {}", i, c);
        }
    }
}

fn main() {
    // Exit if not enough command-line arguments
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        usage();
    }

    // Exit if 1st command-line argument not an integer
    let mut input_value: Option<i32> = parse_int(&args[1]);
    if input_value.is_none() {
        usage();
    }

    let input_num: i32 = input_value.unwrap();

    fibonacci(input_num);
}
