const error_msg = "Usage: please provide a string";
const inputString = process.argv[2].trim().replace(/\\n|\\t|\\r/g, ' ')
const words = inputString.split(' ')
if (process.argv.length < 3) {
  console.log(error_msg);
  process.exit(1);
}

if (inputString.trim() === "") {
  console.log(error_msg);
  process.exit(1);
}

let longestWordLength = 0;

for (const word of words) {
  if (word.length > longestWordLength) {
    longestWordLength = word.length;
  }
}

console.log(longestWordLength);
