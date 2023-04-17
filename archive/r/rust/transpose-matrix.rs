use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!("Usage: please enter the dimension of the matrix and the serialized matrix");
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
        )
    }
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
    // Convert 1st command-line argument to integer
    let num_cols: i32 = parse_int(
        args().nth(1).unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    // Convert 2nd command-line argument to integer
    let num_rows: i32 = parse_int(
        args().nth(2).unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    // Convert 3rd command-line argument to list of integers
    let arr: Vec<i32> = parse_int_list(
        args().nth(3)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Exit if invalid number of columns, rows, and size of array
    if num_cols < 0 ||
        num_rows < 0 ||
        arr.len() != (num_cols * num_rows) as usize {
        usage()
    }

    // Convert array to matrix
    let matrix: Matrix = convert_array_to_matrix(
        arr, num_rows as usize, num_cols as usize
    );

    // Transpose matrix
    let matrix_t = transpose_matrix(matrix);

    // Show transposed matrix as an array
    let arr_t = convert_matrix_to_array(matrix_t);
    println!("{arr_t:?}");
}
