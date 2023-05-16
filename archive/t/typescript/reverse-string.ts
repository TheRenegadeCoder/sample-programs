let myString: string = (process.argv.length >= 3) ? process.argv[2] : "";

const reverse = (str: string) => str.split("").reverse().join("");

console.log(reverse(myString));
