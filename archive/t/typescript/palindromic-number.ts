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
            console.log("true");
        } else {
            console.log("false");
        }
    } else {
        console.log("Usage: please input a non-negative integer");
    }
}
