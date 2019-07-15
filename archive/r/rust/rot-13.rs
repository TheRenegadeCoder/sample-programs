use std::env;

fn rot13(input: String) -> String {
    let mut output = String::new();
    
    for character in input.chars() {
        let offset;

        if character.is_ascii_lowercase() {
            offset = 'a' as u8;
        }
        else if character.is_ascii_uppercase() {
            offset = 'A' as u8;
        }
        else {
            output.push(character);
            continue;
        }
    
        let mut rotated = character as u8;
        rotated -= offset;
        rotated += 13;
        rotated %= 26;
        rotated += offset;
        
        output.push(rotated as char);
    }
    
    return output;
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if (args.len() == 1) {
        println!("Usage: please provide a string to encrypt");
        return;
    }
    
    let input = args[1].to_string();
    if (input.is_empty()) {
        println!("Usage: please provide a string to encrypt");
        return;
    }
    
    let output = rot13(input);
    println!("{}", output);
}