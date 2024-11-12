let myString: string = (process.argv.length >= 3) ? process.argv[2] : "";

const removeAllWhitespace = (str: string): string => str.replace(/[\s\r\n\t]/g, "");

if (myString === "") {
  console.log("Usage: please provide a string");
} else {
  console.log(removeAllWhitespace(myString));
}