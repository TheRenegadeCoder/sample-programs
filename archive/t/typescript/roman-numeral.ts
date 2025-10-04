// Roman Numeral Conversion

const romanNumeralValues = {
  "I": 1,
  "V": 5,
  "X": 10,
  "L": 50,
  "C": 100,
  "D": 500,
  "M": 1000
};

function romanNumeralConversion(str?: string) {

  // Check for blank input
  if (str === undefined) {
    return "Usage: please provide a string of roman numerals";
  }

  // Check for empty string
  if (str === "") {
    return 0;
  }

  // Get valid characters
  const validValues = Object.keys(romanNumeralValues)

  // Check for invalid characters
  for (let i = 0; i < str.length; i++) {
    const char = str.charAt(i)
    if (char === undefined || validValues.indexOf(char) === -1) {
      return "Error: invalid string of roman numerals";
    }
  }

  // Calculating result (adding/subtracting)
  // 
  // Note: next will be undefined for the last element, it'll
  // still work though since 'any number' < undefined will
  // be false ... hacky - but works!
  //
  // Note 2: This does not account for wrongly formatted
  // Roman Numerals like IIIIIIIIIX

  let answer = 0;
  for (let i = 0; i < str.length; i++) {
    const curr = romanNumeralValues[str.charAt(i)];
    const next = romanNumeralValues[str.charAt(i+1)];
    if (curr < next) {
      answer -= curr;
    } else {
      answer += curr;
    }
  }

  return answer;
}


// CLI use needs to have node.js installed
// Run like so:
//   node roman-numeral.js IIIIIIXXVXIV


// Process arguments from CLI
const args = process.argv.slice(2);

if (args.length < 1) {
  console.error("Usage: please provide a string of roman numerals");
} else {
  console.info(romanNumeralConversion(args[0]))
}

