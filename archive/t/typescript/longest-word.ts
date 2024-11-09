const error_message: string = "Usage: please provide a string";

function longestWord(input: string): number {

    const separatedWords: string[] = input.split(' ');

    let longestWord: string = "";
    let wordLength: number = 0;

    for (let word of separatedWords) {
        if (word.length > longestWord.length) {
            longestWord = word;
            wordLength = word.length;
        }
        else if (word == "") {
            console.log(error_message);
        }
    }

    return wordLength;
}