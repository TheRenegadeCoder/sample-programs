use std::env::args;
use std::str::FromStr;
use std::process::exit;

fn usage() -> ! {
    println!("Usage: please provide two lists in the format \"1, 2, 3, 4, 5\"");
    exit(0);
}

fn parse_int<T: FromStr>(s: &str) -> Result<T, <T as FromStr>::Err> {
    s.trim().parse::<T>()
}

fn parse_int_list<T: FromStr>(s: &str) -> Result<Vec<T>, <T as FromStr>::Err> {
    s.split(',')
        .map(parse_int)
        .collect::<Result<Vec<T>, <T as FromStr>::Err>>()
}

type Matrix<T> = Vec<Vec<T>>;

// Longest Common Sequence
// Source: https://en.wikipedia.org/wiki/Longest_common_subsequence#Example_in_C#
//
// However, instead of storing lengths, an index to the subsequence is stored
fn longest_common_subsequence(list1: &Vec<i32>, list2: &Vec<i32>) -> Vec<i32> {
    // Initialize all subsequences to an empty sequence
    let m = list1.len();
    let n = list2.len();
    let mut c: Matrix<usize> = vec![vec![0; n + 1]; m + 1];
    let mut subsequences: Matrix<i32> = vec![vec![]];

    // Find the longest common subsequence using prior subsequences
    for i in 1..=m {
        for j in 1..=n {
            // If common element found, create new subsequence based on prior
            // subsequence with the common element appended
            if list1[i - 1] == list2[j - 1] {
                c[i][j] = subsequences.len();
                let mut new_subsequence = subsequences[c[i - 1][j - 1]].clone();
                new_subsequence.push(list1[i - 1]);
                subsequences.push(new_subsequence);
            }
            // Else, reuse the longer of the two prior subsequences
            else {
                let index1 = c[i][j - 1];
                let index2 = c[i - 1][j];
                c[i][j] = if subsequences[index1].len() > subsequences[index2].len() {
                    index1
                }
                else {
                    index2
                }
            }
        }
    }

    subsequences[c[m][n]].clone()
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let mut list1: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to list of integers
    let mut list2: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Get longest common subsequence and display it
    let result = longest_common_subsequence(&list1, &list2);
    println!("{result:?}");
}
