const myStr: string = "hello world";

const capitalize = (str: string = "no input was provided") => str[0].toUpperCase() + str.slice(1);

console.log(capitalize(myStr));