const input = Number(process.argv[2]); //coerce the input into a number if possible
if(!Number.isInteger(input)){ //if there is no input, input = undefined and the statement still prints
    console.log('Usage: please input a number');
} else {
    console.log(input%2 === 0 ? 'even' : 'odd');
}
