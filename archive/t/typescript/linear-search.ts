const error_msg: string = "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")";
if (process.argv.length != 4) {
    console.log(error_msg);
    process.exit(1);
}
let list: number[] = process.argv[2].split(",").map((x: string) => parseInt(x));
let target: number = parseInt(process.argv[3]);
console.log(list);

if (isNaN(target) || list.length == 0) {
    console.log(error_msg);
    process.exit(1);
}
let found: boolean = false;
for (let i = 0; i < list.length; i++) {
    if (list[i] == target) {
        found = true;
        break;
    }
}
console.log(found ? "true" : "false");


