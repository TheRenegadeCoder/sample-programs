// Accept a string in command line from User and Capitalize the first letter of that string
// Rust is built to support not just ASCII, but Unicode by-default.
// Do note, each character in string is multi-byte UTF-8 supported, which needs upto 3 bytes (to accommodate Japanese letters)
// Best part of Rust compiler issues warning to remove unused variables, functions, ...
fn main() {
    //confirm string is passed as commandline argument
    let mut input_value = std::env::args().nth(1).expect("Kindly pass the string as Command line Argument");
    // Trim the trailing newline
    input_value = input_value.trim_end().to_string();
    // convert to vector
    let mut buff: Vec<char> = input_value.chars().collect();
    // Change the 1'st letter to capital case
    buff[0] = buff[0].to_uppercase().nth(0).unwrap();
    // convert to string for printing
    let buff_hold: String = buff.into_iter().collect();
    // {} will print string without double quotes {:?} will print string with double quotes
    println!("{}", buff_hold);
    }
