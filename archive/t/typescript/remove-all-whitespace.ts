function removeAllWhitespace(input: string): string {
    return input.replace(/\s+/g, "");
}

function main() {
    if (process.argv.length < 3) {
        console.log("Usage: please provide a string");
        return;
    }

    const input = process.argv[2];
    const result = removeAllWhitespace(input);
    console.log(result);
}

main();