function removeAllWhitespace(input: string): string {
    // regu;ar expression to replace all whitespace character with an empty string
    return input.replace(/\s+/g, "");
}

function main() {
    // check if there is an input provided, and if its not an empty string
    if (process.argv.length < 3 || process.argv[2].trim() === "") {
        console.log("Usage: please provide a non-empty string");
        return;
    }

    const input = process.argv[2];
    
    // check if the input is only whitespace
    if (!/\S/.test(input)) {
        console.log("Result: The input is whitespace only.");
        return;
    }

    // remove all whitespace from the input
    const result = removeAllWhitespace(input);

    // output for result.
    console.log(`Result without whitespace: "${result}"`);
}

// run the program
main();
