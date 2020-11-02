const [, , array, target] = process.argv;
const error = 'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")';

const binarySearch = (array, target, start = 0, end = array.length - 1) => {

  const isOrdered = array.every((num, i, arr) => !i || num >= arr[i - 1]);
  if (!isOrdered) return error;

  const middleIndex = Math.floor((start + end) / 2);
  const middleValue = array[middleIndex];
  const newIndexes =
    target < middleValue ? [start, middleIndex - 1] : [middleIndex + 1, end];

  return middleValue === target
    ? true
    : start >= end
        ? false
        : binarySearch(array, target, ...newIndexes);
};

console.log(array && target ? binarySearch(array.split(', '), target) : error);
