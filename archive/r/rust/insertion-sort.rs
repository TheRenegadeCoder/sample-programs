use std::env;

fn insertion_sort(arr: &mut Vec<i32>) {
  for i in 0..arr.len() {
    for j in (0..i).rev() {
      if arr[j] >= arr[j+1] {
        arr.swap(j, j+1);
      } else {
        break;
      }
    }
  }
}

fn main() {
  let err_msg = "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"";
  let args: Vec<String> = env::args().collect();

  if args.len() < 2 {
    panic!(err_msg);
  }

  let mut arr: Vec<i32> = args[1].clone()
    .split(",")
    .map(|s| s.trim().parse().expect(err_msg))
    .collect();

  if arr.len() < 2 {
    panic!(err_msg);
  }
  
  insertion_sort(&mut arr);
  println!("{:?}", arr);
}
