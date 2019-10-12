/**
 * Bubble sort algorithm
 *
 * @param {Integer array} arr
 */

function bubblesort(arr) {
    let swap;

    // repeat while array is unsorted
    do {
        swap = false;

        // iterate array
        for (let index = 0; index < arr.length - 1; index++) {
            // if current item is out of order
            if (arr[index] > arr[index + 1]) {
                // hotswap the current element with the next element
                [arr[index], arr[index + 1]] = [arr[index + 1], arr[index]];

                // flag that list was unordered in this pass
                swap = true;
            }
        }

    } while (swap);

    return arr;
}

/**
 * Executable function
 * 
 * @param {Command line input} input
 */

function main(input) {
    // usage text
    const usage = `Usage: please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”`;

    /**
     * If the string matches the format `"[number], [number], (... [number])"`
     * we have a valid input.
     */
    const inputValidation = /^(\d+,\s*){2,}$/m;

    if (inputValidation.test(input)) {
        // valid input
        let arr;

        /**
         * Format string to be bubblesorted.
         *  - strip all whitespace
         *  - split into array at ',' character
         *  - convert all elements to integers
         *  - filter out NaN elements (uncaught text characters or empty elements)
         */
        arr = input.replace(/\s/g, '');
        arr = arr.split(',');
        arr = arr.map(function (n) {
            return parseInt(n, 10);
        });
        arr = arr.filter(n => n);

        // apply bubblesort and output result
        console.log(bubblesort(arr));
    }
    else {
        // invalid input
        console.log(usage);
    }
}

// run the executable function
const input = process.argv[2];
main(input);
