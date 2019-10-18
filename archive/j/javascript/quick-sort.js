/**
 * Quick sort algorithm
 *
 * @param {Integer array} arr
 */

const quickSort = (arr, start, end) => {
  if(start < end) {
    let pivot = partition(arr, start, end)
    quickSort(arr, start, pivot - 1)
    quickSort(arr, pivot + 1, end)
  } 
}

const partition = (arr, start, end) => { 
  let pivot = end
  let i = start - 1
  let j = start
  while (j < pivot) {
    if (arr[j] > arr[pivot]) {
      j++
    } else {
      i++
      swap(arr, j, i)
      j++
    }
  }
  swap(arr, i + 1, pivot)
  return i + 1
}

const swap = (arr, first, second) => {
  let temp = arr[first]
  arr[first] = arr[second]
  arr[second] = temp
}

const main = (input) => {
    /**
     * If the string matches the format `"[number], [number], (... [number])"`,
     * we have a valid input.
     */
    const inputValidation = /^"?(\d+,\s*){2,}\d+(,"?|"?)$/gm;

    if (inputValidation.test(input) == true) {
        // valid input
        let arr;

        /**
         * Format string to be quicksorted.
         *  - strip all whitespace and quotations
         *  - split into array at ',' character
         *  - convert all elements to integers
         *  - filter out NaN elements (uncaught text characters or empty elements)
         */
        arr = input.replace(/(\s|"|'|`)/g, '');
        arr = arr.split(',');
        arr = arr.map(function (n) {
            return parseInt(n, 10);
        });
        arr = arr.filter(n => n);

        // apply quicksort and output result
        quickSort(arr, 0, arr.length - 1)
        console.log(arr)
    }
    else {
        // invalid input
        console.log(usage);
    }
}

const usage = `Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"`;

if (process.argv.length > 2) {
    const input = process.argv[2];
    main(input);
}
else {
    console.log(usage);
}


