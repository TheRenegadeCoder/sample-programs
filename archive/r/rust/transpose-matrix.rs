use std::env::args;
use std::process::exit;
use std::str::FromStr;

fn usage() -> ! {
    println!("Usage: please enter the dimension of the matrix and the serialized matrix");
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

type Matrix = Vec<Vec<i32>>;

fn convert_array_to_matrix(
    arr: Vec<i32>, num_rows: usize, num_cols: usize
) -> Matrix {
    // Combine 'num_rows' vectors of 'num_cols' items from array
    let mut arr_iter = arr.iter();
    (0..num_rows)
    .map(|_|
        (0..num_cols)
        .map(|_| *arr_iter.next().unwrap())
        .collect::<Vec<i32>>()
    )
    .collect::<Matrix>()
}

fn transpose_matrix(matrix: Matrix) -> Matrix {
    let num_rows = matrix.len();
    let num_cols = matrix[0].len();

    // Construct transposed matrix by grabbing one item from each row
    // and combining them
    (0..num_cols)
        .map(|col|
            (0..num_rows)
                .map(|row| matrix[row][col])
                .collect::<Vec<i32>>()
        )
        .collect::<Matrix>()
}

fn convert_matrix_to_array(matrix: Matrix) -> Vec<i32> {
    let mut arr: Vec<i32> = vec![];
    for mut row in matrix {
        arr.append(&mut row);
    }

    arr
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to integer
    let num_cols: usize = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to integer
    let num_rows: usize = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 3rd command-line argument to list of integers
    let arr: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Exit if invalid number of columns, rows, and size of array
    if num_cols == 0 ||
        num_rows == 0 ||
        arr.len() != num_cols * num_rows {
        usage()
    }

    // Convert array to matrix
    let matrix: Matrix = convert_array_to_matrix(arr, num_rows, num_cols);

    // Transpose matrix
    let matrix_t = transpose_matrix(matrix);

    // Show transposed matrix as an array
    let arr_t = convert_matrix_to_array(matrix_t);
    println!("{arr_t:?}");
}
