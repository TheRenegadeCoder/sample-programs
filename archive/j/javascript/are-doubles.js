/*
build a function which determines whether or not there are double characters in a string (including whitespace characters). 

  doublesCheck("abca")
  //returns false

  doublesCheck("abcc")
  //returns true

  doublesCheck("a 12 c d")
  //returns true

  doublesCheck("a b  c")
  //returns true

  doublesCheck("f g h i h k")
  //returns false


  doublesCheck("a!@€£#$%^&*()_-+=}]{[|\"':;?/>.<,~")
  //returns false

*/

const doublesCheck = (string) => /(.)\1/i.test(string);

console.log(doublesCheck('2022'));
console.log(doublesCheck('abca'));
console.log(doublesCheck('abcc'));
console.log(doublesCheck('a 12 c d'));
console.log(doublesCheck('a!@€£#$%^&*()_-+=}]{[|"\':;?/>.<,~'));
