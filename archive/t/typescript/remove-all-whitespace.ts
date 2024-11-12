function removeAllWhitespace(input: string): string {
    return input.replace(/\s+/g, "");
}

function main() {
    if (process.argv.length < 3 || process.argv[2].trim() === "") {
        console.log("Usage: please provide a non-empty string");
        return;
    }

    const input = process.argv[2];
    const result = removeAllWhitespace(input);
    console.log(result);
}

main();