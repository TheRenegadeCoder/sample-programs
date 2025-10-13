function printUsage() {
  console.log(
    'Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"',
  );
}

function maxSubarraySum(arr) {
  let maxSoFar = -Infinity;
  let maxEndingHere = 0;

  for (let num of arr) {
    maxEndingHere += num;

    if (maxSoFar < maxEndingHere) {
      maxSoFar = maxEndingHere;
    }

    if (maxEndingHere < 0) {
      maxEndingHere = 0;
    }
  }

  return maxSoFar;
}

function main() {
  const args = process.argv.slice(2);

  if (args.length < 1 || args[0] === "") {
    printUsage();
    process.exit(1);
  }
  const input = args[0];
  const arr = input.split(",").map((token) => parseInt(token.trim(), 10));

  if (arr.length === 1) {
    console.log(arr[0]);
    return;
  } else if (arr.length === 0) {
    printUsage();
    process.exit(1);
  }
  const result = maxSubarraySum(arr);

  console.log(result);
}

main();
