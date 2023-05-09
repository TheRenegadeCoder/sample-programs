use std::env::args;
use std::process::exit;

fn usage() -> ! {
    println!("Usage: please provide a string");
    exit(0);
}
fn remove_all_whitespaces(s: String) -> String {
    s.chars().filter(|c| !c.is_whitespace()).collect()
}

fn main() {
    let mut args = args().skip(1);

    // Get first command-line argument
    let s: String = args
        .next()
        .unwrap_or_else(|| usage());

    // Make sure not empty
    if s.len() < 1 {
        usage();
    }

    // Remove all whitespace and show results
    let t: String = remove_all_whitespaces(s);
    println!("{t}");
}
