var longestPalStr = function(string) {

    if (string === undefined || string.length === 0){
        return 'Incorrect input provided';
    }
    var length = string.length;
    var result = "";
  
    var centerPal = function(left, right) {

      // looking for disordered uppercase palindromes
      if (string[left].toLowerCase() ===  string[right].toLowerCase() && string[left] !== ' ' && string[right] !== ' '){
        if(string[left].toUpperCase() === string[left] || string[right].toUpperCase() === string[right]){
            throw new Error('No Palindromic substring present.');
        }
      }
      while (left >= 0 && right < length && string[left] === string[right]) {
        left--;
        right++;
      }
  
      return string.slice(left + 1, right);
    };

    try {
        for (var i = 0; i < length - 1; i++) {

            var oddPal = centerPal(i, i + 1);
            var evenPal = centerPal(i, i);
      
            if (oddPal.length > result.length)
              result = oddPal;
            if (evenPal.length > result.length)
              result = evenPal;
          }

        if (result.length === 1){
            return 'No Palindromic substring present.';
        }
        
        return "Longest Palindromic Substring is: " + result;
    } catch (error) {
        return error.message;
    }    
  };
  
  console.log(
    longestPalStr('Polip')
  );