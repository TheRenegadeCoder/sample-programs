function fibonacci(num: number) {

  let n = Number(num);
  let elementOne: number = 0;
  let elementTwo: number = 1;
  let result: number = 0;

  for (let i: number = 1; i <= n; i++) {
    result = elementOne + elementTwo;
    elementOne = elementTwo;
    elementTwo = result;
    console.log(`Index: ${i}: ${elementOne}`);
  }

}

fibonacci(process.argv[2]);
