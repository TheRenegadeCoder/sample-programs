use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        println!("Usage: please provide a string of roman numerals");
    } else {
        let value: i64 = convert_roman_numeral(&args[1]);
        if value < 0 {
            println!("Error: invalid string of roman numerals");
        } else {
            println!("{value}");
        }
    }
}

fn convert_char(c: char) -> i64 {
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
        return -1;
    }
}

fn convert_roman_numeral(s: &String) -> i64 {
    let mut number: i64 = 0;
    let mut prev_value: i64 = 0;
    for c in s.as_bytes() {
        let value = convert_char(*c as char);
        if value < 0 {
            number = value;
            break;
        }
        number += value;
        if prev_value > 0 && value > prev_value {
            number -= 2*prev_value;
            prev_value = 0;
        } else {
            prev_value = value;
        }
    }

    number
}
