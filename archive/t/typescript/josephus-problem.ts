function printUsage(): void {
  console.error(
    "Usage: please input the total number of people and number of people to skip.",
  );
  process.exit(1);
}

function josephus(n: number, k: number): number {
  if (n === 1) return 1;
  return ((josephus(n - 1, k) + k - 1) % n) + 1;
}

function main(): void {
  const n = Number.parseInt(process.argv[2], 10);
  const k = Number.parseInt(process.argv[3], 10);

  if (Number.isNaN(n) || Number.isNaN(k) || n <= 0 || k <= 0) {
    printUsage();
  }

  console.log(josephus(n, k).toString());
}

main();
