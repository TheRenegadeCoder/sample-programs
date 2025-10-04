function DisplayErrorMessage() {
    console.log(
        `Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"`,
    );
    process.exit(1);
}

/**
 * Processes user arguments from CLI, displays usages message and exits if arguments are incorrect
 * @returns user input argument as a list to be merge sorted
 */
function VerifyUserInput(): number[] {
    if (process.argv.length != 3) {
        DisplayErrorMessage();
    }
    // regex string to match requirements
    const regexStr = /^([0-9]+)((,  ?)([0-9]+))+$/;
    const regex = new RegExp(regexStr);
    const user_arg_pos = 2;
    const numbers: string = process.argv[user_arg_pos];

    if (numbers.length == 0 || !numbers.match(regex)) {
        DisplayErrorMessage();
    }
    // split numbers into array and parse values
    return numbers.split(",").map((x) => parseInt(x));
}

/**
 * Swaps the values of the array at the given positions
 * @param array the array with the values to swap
 * @param i the index of the first value to swap
 * @param j the index of the second value to swap
 * @returns 0 to signify that a swap happened
 */
function Swap(array: number[], i: number, j: number): number {
    //list deconstruction to swap values
    [array[i], array[j]] = [array[j], array[i]];
    return 0;
}

/**
 * Sorts the given array using the Bubble Sort Algorithm
 * @param array the array to be sorted
 */
function BubbleSort(array: number[]) {
    var end = array.length;
    while (end > 1) {
        var new_end = 0;
        for (var i = 1; i < end; i++) {
            if (array[i - 1] > array[i]) {
                Swap(array, i - 1, i)
                new_end = i
            }
        }
        end = new_end
    }
}

/** start of program */
const input: number[] = VerifyUserInput();
BubbleSort(input);
console.log(input.join(", "));
