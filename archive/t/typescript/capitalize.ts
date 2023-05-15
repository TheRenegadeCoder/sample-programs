if (process.argv.length < 3 || process.argv[2].length < 1) {
    console.log("Usage: please provide a string")
    process.exit(0)
}

let myStr: string = process.argv[2];

const capitalize = (str: string) => str[0].toUpperCase() + str.slice(1);

console.log(capitalize(myStr));
