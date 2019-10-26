// Capitalize the first letter of a string
// Rust is built to support not just ASCII, but Unicode by-default.
// Do note, each character in string is multi-byte UTF-8 supported, which needs upto 3 bytes (to accommodate Japanese letters)

// function names have to be strictly in snake case or small case
fn to_title_case(s: &str) -> String {
    let mut buff = s.chars();
    match buff.next() {
        None => String::new(),
        Some(f) => f.to_uppercase().chain(buff).collect(),
    }
}

fn main() {
    println!("{}", to_title_case("rust"));
    println!("{}", to_title_case("turns"));
    println!("{}", to_title_case("dust"));
    println!("{}", to_title_case("to"));
    println!("{}", to_title_case("best"));
}
