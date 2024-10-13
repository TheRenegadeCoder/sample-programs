function selectionSort(arr: number[]): number[] {
    const n = arr.length;

    for (let i = 0; i < n - 1; i++) {
        let minIndex = i;

        for (let j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }

        if (minIndex !== i) {
            const temp = arr[i];
            arr[i] = arr[minIndex];
            arr[minIndex] = temp;
        }
    }

    return arr;
}

function displayUsage() {
    console.log('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
}

const args = process.argv.slice(2);

if (args.length === 0) {
    displayUsage();
    process.exit(1);
}

const inputString = args.join(' ');
if (inputString.trim() === '') {
    displayUsage();
    process.exit(1);
}

if (args.length === 1 && !args[0].includes(',')) {
    displayUsage();
    process.exit(1);
}

const numbers = inputString.split(',').map(arg => parseFloat(arg.trim())).filter(num => !isNaN(num));

if (numbers.length < 2) {
    displayUsage();
    process.exit(1);
}

const sortedNumbers = selectionSort(numbers);

console.log(sortedNumbers.join(', '));
