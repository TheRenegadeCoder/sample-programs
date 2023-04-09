use std::env::args;
use std::process::exit;
use std::num::ParseIntError;
use std::cmp::max;

fn usage() -> ! {
    println!("Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")");
    exit(0);
}

fn parse_int(s: String) -> Result<i32, ParseIntError> {
    s.trim().parse::<i32>()
}

fn parse_int_list(s_list: String) -> Option<Vec<i32>> {
    let results: Vec<Result<i32, ParseIntError>> = s_list.split(",")
        .map(|s| parse_int(s.to_string()))
        .collect();
    match results.iter().any(|s| s.is_err()) {
        true => None,
        false => Some(
            results.iter()
            .map(|result| result.clone().unwrap())
            .collect()
        ),
    }
}

// Find maximum array rotation, max{W(k), k=0..N-1}, where:
//
//     W(k) = sum{i*a[i+k mod N], i=0..N-1}
//
// The value of W(k) can be calculated from W(k-1) as follows:
//
//     W(k) = W(k-1) - S + N*a[k-1]
//
// where:
//
//     S = sum{a[i], i=0..N-1} = sum{a[i+x mod N], i=0..N-1}
//
// where: x is any arbitary value
//
// Proof:
//
// - Set up initial assumption for W(k):
//
//     W(k-1) - S + N*a[k-1] = sum{i*a[i+k-1 mod N], i=0..N-1} - sum{a[i+k-1 mod N}, i=0..N-1} + N*a[k-1]
//
// - Combine the two sums:
//
//     = sum{(i-1)*a[i+k-1 mod N], i=0..N-1} + N*a[k-1]
//
// - Pull out the i=0 term:
//     = -a[k-1] + sum{(i-1)*a[i+k-1 mod N], i=1..N-1} + N*a[k-1]
//
// - Combine the a[k-1] terms:
//
//     = sum{(i-1}*a[i+k-1 mod N], i=1..N-1) + (N-1)*a[k-1]
//
// - Change indexing from i=1..N-1 to 0..N-2:
//
//     = sum{i*a[i+k mod N], i=0..N-2} + (N-1)*a[k-1]
//
// - Bring the i=N-1 term back into the sum since N-1+k mod N equals k-1:
//
//     = sum{i*a[i+k mod N], i=0..N-1}
//
// - The above equals W(k)
fn maximum_array_rotation(arr: &Vec<i32>) -> i32 {
    // Calculate sum and initial array rotation
    let s: i32 = arr.iter()
        .sum::<i32>();
    let n: usize = arr.len();
    let mut w: i32 = (0..n)
        .map(|i| (i as i32) * arr[i])
        .sum::<i32>();

    // Initialize maximum array rotation
    let mut wmax: i32 = w;

    // Adjust array rotation and update maximum
    for value in arr.iter().take(n - 1) {
        w += (n as i32) * value - s;
        wmax = max(w, wmax);
    }

    wmax
}

fn main() {
    // Convert 1st command-line argument to list of integers
    let mut arr: Vec<i32> = parse_int_list(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Exit if list too small
    if arr.len() < 2 {
        usage();
    }

    // Get maximum array rotation and display it
    println!("{}", maximum_array_rotation(&arr));
}
