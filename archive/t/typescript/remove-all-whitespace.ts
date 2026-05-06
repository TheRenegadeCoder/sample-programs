function printUsage(): void {
  console.log("Usage: please provide a string");
  process.exit(1);
}

function main(): void {
  const input = process.argv[2];

  if (process.argv.length !== 3 || !input || input.length === 0) {
    printUsage();
  }

  const result = input.replace(/\s/g, "");
  console.log(result);
}

main();
