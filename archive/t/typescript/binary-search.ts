const error_msg: string = "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")";
if (process.argv.length != 4) {
    console.log(error_msg);
    process.exit(1);
}

let list_str: string = process.argv[2]
let target: number = parseInt(process.argv[3]);

if (isNaN(target) || list_str.length == 0) {
    console.log(error_msg);
    process.exit(1);
}
let list: number[] = list_str.split(",").map((x: string) => parseInt(x));
// check if list is sorted
for (let i: number = 1; i < list.length; i++) {
    if (list[i] < list[i - 1]) {
        console.log(error_msg);
        process.exit(1);
    }
}
let found: boolean = false;
let low: number = 0;
let high: number = list.length - 1;
while (low <= high) {
    let mid: number = Math.floor((low + high) / 2);
    if (list[mid] == target) {
        found = true;
        break;
    }
    if (list[mid] < target) {
        low = mid + 1;
    } else {
        high = mid - 1;
    }
}
console.log(found ? "true" : "false");