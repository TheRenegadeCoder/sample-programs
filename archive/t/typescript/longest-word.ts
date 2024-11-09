if (process.argv.length < 3 || process.argv[2].length < 1) {
    console.log("Usage: please provide a string")
    process.exit(0)
}

let testString: string = process.argv[2];

//     const separatedWords: string[] = input.split(' ');

//     let longestWord: string = "";
//     let wordLength: number = 0;

//     for (let word of separatedWords) {
//         if (word.length > longestWord.length) {
//             longestWord = word;
//             wordLength = word.length;
//         }
//         else if (word == "") {
//             console.log(error_message);
//             process.exit(1);
//         }
//     }

//     return wordLength;
// }