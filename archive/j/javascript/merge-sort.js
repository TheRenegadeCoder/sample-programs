function mergeSort (unsortedArray) {
  if (unsortedArray.length <= 1) {
    return unsortedArray;
  }
  const middle = Math.floor(unsortedArray.length / 2);
  const left = unsortedArray.slice(0, middle);
  const right = unsortedArray.slice(middle);
  return merge(
    mergeSort(left), mergeSort(right)
  );
}

function merge (left, right) {
  let resultArray = [], leftIndex = 0, rightIndex = 0;
  while (leftIndex < left.length && rightIndex < right.length) {
    if (left[leftIndex] < right[rightIndex]) {
      resultArray.push(left[leftIndex]);
      leftIndex++;
    } else {
      resultArray.push(right[rightIndex]);
      rightIndex++;
    }
  }
  return resultArray
          .concat(left.slice(leftIndex))
          .concat(right.slice(rightIndex));
}

const main = (input) => {
    const inputValidation = /^"?(\d+,\s*){2,}\d+(,"?|"?)$/gm;
    if (inputValidation.test(input) == true) {
        let arr;
        arr = input.replace(/(\s|"|'|`)/g, '');
        arr = arr.split(',');
        arr = arr.map(function (n) {
            return parseInt(n, 10);
        });
        arr = arr.filter(n => n);
        arr=mergeSort(arr);
        console.log(arr);
    }
    else {
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