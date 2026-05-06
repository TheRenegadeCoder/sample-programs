function printUsage(): void {
  console.log(
    'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"',
  );
  process.exit(1);
}

function sleepSort(arr: number[]): void {
  const sorted: number[] = [];

  function sleepSortHelper(item: number): void {
    setTimeout(() => {
      sorted.push(item);

      if (sorted.length === arr.length) {
        console.log(sorted.join(", "));
      }
    }, item * 1000);
  }

  arr.forEach((item) => {
    if (item < 0) {
      printUsage();
    }
    sleepSortHelper(item);
  });
}

function parseInput(input: string): number[] {
  return input
    .split(",")
    .map((s) => s.trim())
    .map((s) => Number.parseInt(s, 10));
}

function isValid(arr: number[]): boolean {
  return arr.length >= 2 && !arr.some((n) => Number.isNaN(n));
}

function main(): void {
  const input = process.argv[2];

  if (!input) {
    printUsage();
  }

  const numbers = parseInput(input);

  if (!isValid(numbers)) {
    printUsage();
  }

  sleepSort(numbers);
}

main();
