function insertionSort(arr: number[]): number[] {
  const n = arr.length;

  for (let i = 1; i < n; i++) {
    const currentElement = arr[i];
    let j = i - 1;

    while (j >= 0 && arr[j] > currentElement) {
      arr[j + 1] = arr[j];
      j--;
    }

    arr[j + 1] = currentElement;
  }

  return arr;
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
const sortedArray: number[] = insertionSort(list);
console.log(sortedArray.join(", "));