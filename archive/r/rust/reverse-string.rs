use std::env;

fn main() {
    let mut strings: Vec<String> = env::args().collect();
    strings.remove(0); //Removes path to executable from argument vector.
    for string in &strings {
        println!("{}", string.chars().rev().collect::<String>());
    }
}
