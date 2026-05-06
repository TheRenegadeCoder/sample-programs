function printUsage(): void {
  console.error('Usage: please provide a list of integers (e.g. "8, 3, 1, 2")');
  process.exit(1);
}

function parse(input: string): number[] {
  return input
    .split(",")
    .map((s) => s.trim())
    .filter((s) => s.length > 0)
    .map((s) => Number(s));
}

function maxArrayRotation(arr: number[]): number {
  const n = arr.length;
  if (n === 0) return 0;

  let totalSum = 0;
  let currentSum = 0;

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
}

function main(): void {
  const input = process.argv[2];

  if (!input) {
    printUsage();
  }

  const arr = parse(input);

  if (arr.length === 0 || arr.some((n) => Number.isNaN(n))) {
    printUsage();
  }

  console.log(maxArrayRotation(arr));
}

main();
