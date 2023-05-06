use std::env::args;
use std::process::exit;

fn usage() -> ! {
    println!("Usage: please provide a string");
    exit(0);
}

fn get_longest_word_len(s: &str) -> usize {
    s.trim()
        .split_whitespace()
        .map(|t| t.len())
        .max()
        .unwrap()
}

fn main() {
    let mut args = args().skip(1);

    // Exit if 1st command-line argument is empty
    let s: &str = &args
        .next()
        .unwrap_or_else(|| usage());
    if s.len() < 1 {
        usage();
    }

    // Get longest word length and display it
    println!("{}", get_longest_word_len(s));
}
