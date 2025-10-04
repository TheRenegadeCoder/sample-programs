const error_msg = "Usage: please provide a string";
if (process.argv.length != 3) {
  console.log(error_msg);
  process.exit(1);
}

const inputString = process.argv[2].replace(/\n|\t|\r/g, " ");
if (inputString.trim().length == 0) {
  console.log(error_msg);
  process.exit(1);
}

const words = inputString.trim().split(" ");

let longestWordLength = 0;

for (const word of words) {
  if (word.length > longestWordLength) {
    longestWordLength = word.length;
  }
}

console.log(longestWordLength);
