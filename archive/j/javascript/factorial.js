
function factorial(num) {
    if (num > 1) {
      return num * factorial(num-1);
    } else {
      return 1;
    }
  
  }
  
  
  num = process.argv[2];
  
  if (num && !isNaN(num)) {
    console.log(factorial(num));
  } else {
      console.log("Usage: please input the number to find a factorial for.")
  }
  