// Accept a string from User and Capitalize the first letter of that string
// Rust is built to support not just ASCII, but Unicode by-default.
// Do note, each character in string is multi-byte UTF-8 supported, which needs upto 3 bytes (to accommodate Japanese letters)
// Best part of Rust compiler issues warning to remove unused variables, functions, ...
fn main() {
    // Use Std. Input Device
    use std::io::{stdin};
    // Create a new String Object
    let mut input_value = String::new();
    // Read a mutable input value from Std Input with newline at the end. If it fails, throw Error Message
    stdin().read_line(&mut input_value).expect("Error: reading from keyboard failed");
    // Chomp or Remove the new line at the end of string
    input_value = input_value.trim_end().to_string();
    // COnvert the String Object into Vectorr
	let mut buff: Vec<char> = input_value.chars().collect();
    // Convert 1'st character to Capital letter, Throw Error in case of null string
	buff[0] = buff[0].to_uppercase().nth(0).expect("Updating letter 1 to uppper case failed");
    // Convert vector to String 
	let buff_hold: String = buff.into_iter().collect();
    // Print Updated Value
	
	println! ("String with letter1 capitalised is {:?}", buff_hold);
        }
