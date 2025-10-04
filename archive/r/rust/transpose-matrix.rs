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

type Matrix<T> = Vec<Vec<T>>;

fn convert_array_to_matrix<T: Copy>(
    arr: Vec<T>, num_rows: usize, num_cols: usize
) -> Matrix<T> {
    // Combine 'num_rows' vectors of 'num_cols' items from array
    let mut arr_iter = arr.iter();
    (0..num_rows)
    .map(|_|
        (0..num_cols)
        .map(|_| *arr_iter.next().unwrap())
        .collect::<Vec<T>>()
    )
    .collect::<Matrix<T>>()
}

fn transpose_matrix<T: Copy>(matrix: Matrix<T>) -> Matrix<T> {
    let num_rows = matrix.len();
    let num_cols = matrix[0].len();

    // Construct transposed matrix by grabbing one item from each row
    // and combining them
    (0..num_cols)
        .map(|col|
            (0..num_rows)
                .map(|row| matrix[row][col])
                .collect::<Vec<T>>()
        )
        .collect::<Matrix<T>>()
}

fn convert_matrix_to_array<T: Copy>(matrix: Matrix<T>) -> Vec<T> {
    let mut arr: Vec<T> = vec![];
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
    let matrix: Matrix<i32> = convert_array_to_matrix::<i32>(arr, num_rows, num_cols);

    // Transpose matrix
    let matrix_t = transpose_matrix::<i32>(matrix);

    // Show transposed matrix as an array
    let arr_t = convert_matrix_to_array::<i32>(matrix_t);
    println!("{arr_t:?}");
}
