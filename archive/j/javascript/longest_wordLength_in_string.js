function findLongestWordLength(str) {
  const words = str.split(' ');
  // console.log(words)
  var maxLength = 0;

  for (var i = 0; i < words.length; i++) {
    if (words[i].length > maxLength) {
      maxLength = words[i].length;
    }
  }

  return maxLength;
}

console.log(findLongestWordLength("The quick brown fox jumped over the lazy dog"))