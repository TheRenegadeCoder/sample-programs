const error_msg: string = "Usage: please provide a string"
let str: string = (process.argv.length == 3) ? process.argv[2] : "";
if (str.length == 0) {
    console.log(error_msg);
    process.exit(1);
}

let hash_map: Map<string, number> = new Map<string, number>();
for (let i = 0; i < str.length; i++) {
    let char: string = str[i];
    let count: number = hash_map.get(char) || 0;
    hash_map.set(char, count + 1);
}
let has_duplicate: boolean = false;
hash_map.forEach((value, key) => {
    if (value > 1) {
        has_duplicate = true;
        console.log(`${key}: ${value}`);
    }
});

if (!has_duplicate) {
    console.log("No duplicate characters");
}
