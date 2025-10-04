let error_msg: string = "Usage: please input a non-negative integer"
let num_str: string = (process.argv.length == 3) ? process.argv[2] : ""
let num: number = parseInt(num_str);
if (isNaN(num) || num < 0) {
    console.log(error_msg);
    process.exit(1);
}
let factorial: number = 1;
for (let i = 1; i <= num; i++) {
    factorial *= i;
}
console.log(factorial);
