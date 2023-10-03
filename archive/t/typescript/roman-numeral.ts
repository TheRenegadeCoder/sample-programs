// Roman Numeral Conversion

declare const process: { argv: string[] };

const romanNumeralValues = {
  "I": 1,
  "V": 5,
  "X": 10,
  "L": 50,
  "C": 100,
  "D": 500,
  "M": 1000
};

function romanNumeralConversion(romanNumeral?: string) {

  // Check for blank input
  if (romanNumeral === undefined) {
    return "Usage: please provide a string of roman numerals";
  }

  // Check for empty string
  if (romanNumeral === "") {
    return 0;
  }

  // Split the string
  const romans = romanNumeral.split("");
  // Get valid characters
  const validValues = Object.keys(romanNumeralValues)

  // Check for invalid characters
  for (const roman of romans) {
    if (roman === undefined || validValues.indexOf(roman) === -1) {
      return "Error: " + roman + " is not a valid string of roman numerals";
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
  for (let i = 0; i < romans.length; i++) {
    const curr = romanNumeralValues[romans[i]];
    const next = romanNumeralValues[romans[i+1]];
    if (curr < next) {
      answer -= curr;
    } else {
      answer += curr;
    }
  }

  return answer;
}


// CLI use needs to have node.js and tsc installed
// Run like so:
//   tsc roman-numeral.ts
//   node roman-numeral.js I II III XXV XIV "" HI 700


// Process arguments from CLI
const args = process.argv.slice(2);

if (args.length < 1) {
  console.log(romanNumeralConversion());
} else {
  args.forEach(arg => console.log(romanNumeralConversion(arg)));
}

