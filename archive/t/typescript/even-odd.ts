const error_msg: string = "Usage: please input a number"
let num_str:string = (process.argv.length == 3) ? process.argv[2] : "";
let num:number = parseInt(num_str);
if (isNaN(num)) {
    console.log(error_msg);
    process.exit(1);
}
let is_even:boolean = (num % 2 == 0);
console.log(is_even ? "Even" : "Odd");