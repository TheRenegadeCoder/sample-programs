function quickSort(arr: number[]): number[] {
  if (arr.length <= 1) {
    return arr;
  }

  const pivot = arr[0];
  const left = [];
  const right = [];

  for (let i = 1; i < arr.length; i++) {
    if (arr[i] < pivot) {
      left.push(arr[i]);
    } else {
      right.push(arr[i]);
    }
  }

  return [...quickSort(left), pivot, ...quickSort(right)];
}

const error_msg: string =
  'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"';

if (process.argv.length != 3) {
  console.log(error_msg);
  process.exit(1);
}

let list_str: string = process.argv[2];

if (list_str.length == 0) {
  console.log(error_msg);
  process.exit(1);
}
let list: number[] = list_str.split(",").map((x: string) => parseInt(x));
if (list.length < 2) {
  console.log(error_msg);
  process.exit(1);
}
const sortedArray: number[] = quickSort(list);
console.log(sortedArray.join(", "));
