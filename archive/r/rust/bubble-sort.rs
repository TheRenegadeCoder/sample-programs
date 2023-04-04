use std::env;
use std::process;

fn bubble_sort(arr: &mut Vec<i32>) {
  let mut swap_occured = true;

  while swap_occured {
    swap_occured = false;

    for i in 1..arr.len() {
      if arr[i - 1] > arr[i] {
        arr.swap(i - 1, i);
        swap_occured = true;
      }
    }
  }
}

fn parse_int(s: &String) -> Option<i32> {
  match s.trim().parse::<i32>() {
      Ok(n) => Some(n),
      Err(e) => None,
  }
}

fn parse_int_list(s_list: &String) -> Vec<i32> {
  let results: Vec<Option<i32>> = s_list.split(",")
    .map(|s| parse_int(&s.to_string()))
    .collect();
  if results.iter().any(|s| s.is_none()) {
    vec![]
  }
  else {
    results.iter().map(|result| result.unwrap()).collect()
  }
}

fn main() {
  let err_msg = "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"";
  let args: Vec<String> = env::args().collect();

  if args.len() < 2 {
    println!("{err_msg}");
    process::exit(0);
  }

  let mut arr: Vec<i32> = parse_int_list(&args[1]);

  if arr.len() < 2 {
    println!("{err_msg}");
    process::exit(0);
  }

  bubble_sort(&mut arr);
  println!("{:?}", arr);
}

