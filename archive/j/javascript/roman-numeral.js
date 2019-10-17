// Roman Numeral Conversion
// jsfiddle link for a quick test drive: https://jsfiddle.net/Rani_Kheir/r8wpLagq/10/

let romanNumeralValues = {
  "I": 1,
  "V": 5,
  "X": 10,
  "L": 50,
  "C": 100,
  "D": 500,
  "M": 1000
};

function romanNumeralConversion(romanNumeral) {

  // Check for blank input
  if (romanNumeral === undefined) {
    return "Usage: please provide a string of roman numerals";
  }

  // Check for empty string
  if (romanNumeral === "") {
    return 0;
  }

  // Split the string
  let romanNumeralSplit = romanNumeral.split("");
  // Get unique characters
  let unique = [... new Set(romanNumeralSplit)];

  // Check for invalid characters
  for (var i = 0; i < unique.length; i++) {
    if (romanNumeralValues[unique[i]] === undefined) {
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

  for (var i = 0; i < romanNumeralSplit.length; i++) {
    var curr = romanNumeralValues[romanNumeralSplit[i]];
    var next = romanNumeralValues[romanNumeralSplit[i+1]];
    if (curr < next)
      answer -= curr;
    else
      answer += curr;
  }

  return answer;
}


// CLI use needs to have node.js installed
// Run like so:
//   node roman-numeral.js I II III XXV XIV "" HI 700


// Process arguments from CLI

var args = process.argv.slice(2);

if (args.length < 1) {
  console.log(romanNumeralConversion());
} else {
  args.forEach(arg => console.log(romanNumeralConversion(arg)));
}

