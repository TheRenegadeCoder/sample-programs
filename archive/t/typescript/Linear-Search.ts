function isPrime(num: number): boolean {
  if (num < 2) {
    return false;
  }
  for (let i = 2; i <= Math.sqrt(num); i++) {
    if (num % i === 0) {
      return false;
    }
  }
  return true;
}

function main() {
  if (process.argv.length !== 3) {
    console.log('Usage: please input a non-negative integer');
    return;
  }

  const inputNum = parseInt(process.argv[2], 10);

  if (isNaN(inputNum) || inputNum < 0 || inputNum % 1 !== 0) {
    console.log('Usage: please input a non-negative integer');
    return;
  }

  if (isPrime(inputNum)) {
    console.log('prime');
  } else {
    console.log('composite');
  }
}
main();
