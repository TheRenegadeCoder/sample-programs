use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        println!("Usage: {} ROMAN NUMERAL", args[0]);
    } else {
        println!("{}", convert_roman_numeral(&args[1]));
    }
}

fn convert_char(c: char) -> u64 {
    if c == 'I' {
        return 1;
    } else if c == 'V' {
        return 5;
    } else if c == 'X' {
        return 10;
    } else if c == 'L' {
        return 50;
    } else if c == 'C' {
        return 100;
    } else if c == 'D' {
        return 500;
    } else if c == 'M' {
        return 1000;
    } else {
        return 0;
    }
}

fn convert_roman_numeral(s: &String) -> u64 {
    let mut number = 0u64;
    for c in s.as_bytes() {
        number += convert_char(*c as char)
    }

    number
}