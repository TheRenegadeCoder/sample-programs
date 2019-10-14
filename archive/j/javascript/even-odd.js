const input = process.argv[2] != '' ? Number(process.argv[2]) : null; //coerce the input into a number, ignore empty string
if(!Number.isInteger(input)){ //if there is no input, input = undefined and the statement still prints
    console.log('Usage: please input a number');
} else {
    console.log(input%2 === 0 ? 'Even' : 'Odd');
}
