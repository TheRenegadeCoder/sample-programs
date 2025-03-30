use std::env::args;
use std::process::exit;

const BASE64_CHARS: [char; 64] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', //
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', //
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', //
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', //
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/', //
];

// Each tuple contains string index and number of shifts
const BASE64_ENCODE_TABLE: [(usize, u32); 4] =
    [(0usize, 18), (0usize, 12), (1usize, 6), (2usize, 0)];
const BASE64_DECODE_TABLE: [(usize, u32); 3] = [(0usize, 16), (2usize, 8), (3usize, 0)];

fn usage() -> ! {
    println!("Usage: please provide a mode and a string to encode/decode");
    exit(0);
}

fn base64_encode(s: &str) -> String {
    // Break up string into 3-byte chunks, Base64 encode each chunk, and concatenate
    s.as_bytes().chunks(3).map(base64_encode_chunk).collect()
}

fn base64_encode_chunk(s: &[u8]) -> String {
    // Base64 encode a chunk of 3 bytes, pad with "=" if shorter than 3 bytes
    let s_len = s.len();
    let u = s.iter().fold(0u32, |acc, &c| (acc << 8) | (c as u32)) << (24 - 8 * s_len);
    BASE64_ENCODE_TABLE
        .iter()
        .map(|(n, shifts)| match n < &s_len {
            true => BASE64_CHARS[((u >> shifts) & 0x3f) as usize],
            false => '=',
        })
        .collect()
}

fn base64_decode(s: &str) -> Option<String> {
    // Return None if length is not a multiple of 4 or pad length is more than 2
    let s_len = s.len();
    let pad_len = s_len - s.trim_end_matches('=').len();
    if s_len % 4 != 0 || pad_len > 2 {
        return None;
    }

    // Break string (excluding pad characters) into chunks of 4 bytes, Base64
    // decode each chunk, and concatenate. Return None if any in invalid
    // Base64 characters
    let mut result = String::from("");
    for chunk in s[..(s_len - pad_len)].as_bytes().chunks(4) {
        result += base64_decode_chunk(chunk)?.as_str();
    }

    Some(result)
}

fn base64_decode_chunk(s: &[u8]) -> Option<String> {
    // Convert chunk into Base64 indices. Return None if any invalid Base64
    // characters
    let indices = s.iter().map(base64_index).collect::<Vec<_>>();
    if indices.iter().any(|&n| n.is_none()) {
        return None;
    }

    // Base64 decode chunk
    let s_len = s.len();
    let u = indices
        .iter()
        .fold(0u32, |acc, x| (acc << 6) | (x.unwrap() as u32))
        << (24 - 6 * s_len);
    Some(
        BASE64_DECODE_TABLE
            .iter()
            .filter(|(n, _)| n < &s_len)
            .map(|(n, shifts)| (((u >> shifts) & 0xff) as u8) as char)
            .collect(),
    )
}

fn base64_index(c: &u8) -> Option<u8> {
    // Convert byte to Base64 index. None is returned when there is an invalid byte
    match c {
        b'A'..=b'Z' => Some(c - b'A'),
        b'a'..=b'z' => Some(c - b'a' + 26),
        b'0'..=b'9' => Some(c - b'0' + 52),
        b'+' => Some(62),
        b'/' => Some(63),
        _ => None,
    }
}

fn main() {
    let mut args = args().skip(1);

    // Get mode and string to encode/decode
    let mode = args.next().unwrap_or_else(|| usage());
    let s = args
        .next()
        .and_then(|s| if s.len() > 0 { Some(s) } else { None })
        .unwrap_or_else(|| usage());

    // Encode or decode string
    let result = match mode.as_str() {
        "encode" => base64_encode(&s),
        "decode" => base64_decode(&s).unwrap_or_else(|| usage()),
        _ => usage(),
    };
    println!("{result}");
}
