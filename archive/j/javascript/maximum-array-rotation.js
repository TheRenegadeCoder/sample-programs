"use strict";

const USAGE = 'Usage: please provide a list of integers (e.g. "8, 3, 1, 2")';

const parse = (s) =>
  s
    .split(",")
    .filter((x) => x.trim() !== "")
    .map((x) => Number(x.trim()));

const maxArrayRotation = (arr) => {
  const n = arr.length;
  if (n === 0) return 0;

  let currentSum = 0;
  let totalSum = 0;

  for (let i = 0; i < n; i++) {
    totalSum += arr[i];
    currentSum += i * arr[i];
  }

  let maxSum = currentSum;

  for (let k = 1; k < n; k++) {
    const droppedValue = arr[n - k];
    currentSum = currentSum + totalSum - n * droppedValue;

    if (currentSum > maxSum) {
      maxSum = currentSum;
    }
  }

  return maxSum;
};

const run = () => {
  const [, , input] = process.argv;

  if (!input) {
    console.error(USAGE);
    process.exit(1);
  }

  const arr = parse(input);

  if (arr.length === 0 || arr.some(Number.isNaN)) {
    console.error(USAGE);
    process.exit(1);
  }

  console.log(maxArrayRotation(arr));
};

run();
