function removeAllWhitespace(input: string): string {
    // remove all whitespace from the string
    return input.replace(/\s+/g, "");
}

function main() {
    // checking ig there is an input provided
    if (process.argv.length < 3 || process.argv[2].trim() === "") {
        console.log("Usage: please provide a non-empty string");
        return;
    }

    // retrieve input and remove whitespace
    const input = process.argv[2];
    const result = removeAllWhitespace(input);
    console.log(result);
}

// run the program
main();