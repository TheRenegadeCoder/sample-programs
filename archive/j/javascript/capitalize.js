function capitalize(stringToCapitalize) {
    return stringToCapitalize[0].toUpperCase() + stringToCapitalize.slice(1);
}

function main() {
    if (process.argv.length == 3 && process.argv[2].length > 0) {
        let input = process.argv[2];
        console.log(capitalize(input)); 
    } else {
        console.log("Usage: please provide a string");
    }
}

main();
