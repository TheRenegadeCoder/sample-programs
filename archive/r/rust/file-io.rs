use std::fs::File;
use std::io::prelude::*;
use std::io::Result;

fn write_file() -> Result<()> {
    let mut out = File::create("output.txt")?;

    out.write(b"A line of text written to this file in Rust!\n");
    out.write(b"Another line also written by a Rust program!\n");

    out.flush();

    Ok(())
}

fn read_file() -> Result<()> {
    let mut in_file = File::open("output.txt")?;

    let mut line = String::new();
    in_file.read_to_string(&mut line);

    println!("{}", line);

    Ok(())
}

fn main() {
    write_file();
    read_file();
}