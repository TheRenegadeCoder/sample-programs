use std::fs::File;
use std::io::prelude::*;
use std::io::Result;

fn write_file() -> Result<()> {
    let mut out = File::create("output.txt")?;

    let bytes_written = out.write(b"A line of text written to this file in Rust!\n").unwrap_or(0);
    let bytes_written2 = out.write(b"Another line also written by a Rust program!\n").unwrap_or(0);

    if bytes_written == 0 || bytes_written2 == 0 {
        ()
    }

    out.flush()?;

    Ok(())
}

fn read_file() -> Result<()> {
    let mut in_file = File::open("output.txt")?;

    let mut line = String::new();
    match in_file.read_to_string(&mut line) {
        Ok(_)   =>  println!("{}", line),
        Err(_)  =>  panic!("Could not read contents into string!")
    }

    Ok(())
}

fn main() -> Result<()> {
    write_file()?;
    Ok(read_file()?)
}