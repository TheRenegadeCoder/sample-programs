if (process.argv.length < 3 || process.argv[2].length < 1) {
    console.log("Usage: please provide a string")
    process.exit(0)
}

let testString: string = process.argv[2].replace(/\n|\t|\r/g, " ");

const separatedWords: string[] = testString.split(' ');

let longestWord: string = "";
let wordLength: number = 0;

for (let word of separatedWords) {
    if (word.length > longestWord.length) {
        longestWord = word;
        wordLength = word.length;
    }
}

console.log(wordLength);
