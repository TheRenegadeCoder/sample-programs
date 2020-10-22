const [, , input] = process.argv;

const getLongestPalindromic = (string) => {
  let longestPal = '';

  for (let i = 1; i < string.length; i++) {
    for (let j = 0; j < string.length - i; j++) {
      let possiblePal = string.substring(j, j + i + 1);
      if (
        possiblePal === [...possiblePal].reverse().join('') &&
        possiblePal.length > longestPal.length
      )
        longestPal = possiblePal;
    }
  }

  return longestPal
    ? `Longest Palindromic Substring is: ${longestPal}`
    : 'No Palindromic substring present.';
};

console.log(
  input
    ? getLongestPalindromic(input)
    : 'Incorrect input provided. Program Terminated'
);