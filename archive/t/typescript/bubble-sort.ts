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
 * Compares two values from the given array
 * @param array the array with the values
 * @param i the left value to compare
 * @param j the right value to compare
 * @returns true if i < j else false
 */
function Compare(array: number[], i: number, j: number) {
    return array[j] < array[i];
}

/**
 * Sorts the given array using the Bubble Sort Algorithm
 * @param array the array to be sorted
 */
function BubbleSort(array: number[]) {
    const end = array.length;
    var i = 0,
        j = 1,
        start = 0,
        done = 0;
    while (done < end) {
        /* Swap returns 0 to signify that bubble sort should do another pass */
        done = Compare(array, i, j) ? Swap(array, i, j) : done + 1;
        /* left value index - cycles between 0 and length - 1 of the array. */
        i = i < end - 1 ? (i + 1) % end : start;
        /* right value index */
        j = i + 1;
    }
}

/** start of program */
const input: number[] = VerifyUserInput();
BubbleSort(input);
console.log(input.join(", "));
