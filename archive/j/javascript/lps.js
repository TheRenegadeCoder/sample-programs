const [, , input] = process.argv;

const getLongestPalindromic = (string) => {
  if (!string) return;

  let longestPal = '';

  for (let i = 1; i < string.length; i++) {
    for (let j = 0; j < string.length - i; j++) {
      let possiblePal = string.substring(j, j + i + 1).toLowerCase();

      if (
        possiblePal === [...possiblePal].reverse().join('') &&
        possiblePal.length > longestPal.length
      )
        longestPal = possiblePal;
    }
  }

  return longestPal;
};

console.log(
  getLongestPalindromic(input) ||
    'Usage: please provide a string that contains at least one palindrome'
);