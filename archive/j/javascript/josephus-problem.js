const josephus = (n, k) => {
    if (n == 1) return 1;
    else return ((josephus(n - 1, k) + k - 1) % n) + 1;
};

const usage =
    "Usage: please input the total number of people and number of people to skip.";

const n = parseInt(process.argv[2]);
const k = parseInt(process.argv[3]);

if (!n || !k || typeof n !== "number" || typeof k !== "number") {
    return console.log(usage);
}

console.log(josephus(n, k));
