function isPalindrome(num: number): boolean {
    const numStr = num.toString();
    const reversedNumStr = numStr.split('').reverse().join('');
    return numStr === reversedNumStr;
}

if (process.argv.length !== 3) {
    console.log("Usage: please input a non-negative integer");
} else {
    const input = process.argv[2];
    const numberToCheck = parseFloat(input);

    if (!isNaN(numberToCheck) && Number.isInteger(numberToCheck) && numberToCheck >= 0) {
        if (isPalindrome(numberToCheck)) {
            console.log(`${numberToCheck} is a palindrome.`);
        } else {
            console.log(`${numberToCheck} is not a palindrome.`);
        }
    } else {
        console.log("Usage: please input a non-negative integer");
    }
}
