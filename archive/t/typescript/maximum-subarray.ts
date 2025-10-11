function printUsage(): void {
    console.log('Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"');
}

function maxSubarraySum(arr: number[]): number {
    let maxSoFar = Number.MIN_SAFE_INTEGER;
    let maxEndingHere = 0;

    for (let i = 0; i < arr.length; i++) {
        maxEndingHere += arr[i];

        if (maxSoFar < maxEndingHere) {
            maxSoFar = maxEndingHere;
        }

        if (maxEndingHere < 0) {
            maxEndingHere = 0;
        }
    }

    return maxSoFar;
}

function main(): void {
    const args = process.argv.slice(2);

    if (args.length < 1) {
        printUsage();
        process.exit(1);
    }

    // Check if input is empty
    if (args[0].length === 0) {
        printUsage();
        process.exit(1);
    }

    // Parse input string
    const arr = args[0].split(',').map(s => parseInt(s.trim()));

    // If less than two integers were provided
    if (arr.length === 1) {
        console.log(arr[0]);
        return;
    } else if (arr.length < 1) {
        printUsage();
        process.exit(1);
    }

    // Calculate maximum subarray sum
    const result = maxSubarraySum(arr);

    console.log(result);
}

main();
