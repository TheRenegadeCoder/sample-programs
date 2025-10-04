const isPalindromic = (number) => {
    if (number <= 1) {
        console.log("Usage: please input a non-negative integer");
        process.exit(1);
    }

    let reverse_number = 0, temp = number;
    while (temp > 0) {
        reverse_number = (reverse_number * 10) + (temp % 10);
        temp = Math.floor(temp / 10);
    }

    if (reverse_number == number)
        return true;
    else
        return false;

};

const input = process.argv[2];
let number = Number(input)

if (input !== '' && Number.isInteger(number) && number >= 0) {
    isPalindromic(input) ? console.log("true") : console.log("false");
} else {
    console.log("Usage: please input a non-negative integer")
}
