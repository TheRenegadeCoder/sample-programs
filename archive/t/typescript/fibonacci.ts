function fibonacci(num: number) {

  let n = Number(num);
  let first = 0;
  let second = 1;
  let result = 0;

  for (var i = 1; i <= n; i++) {
    result = first + second;
    first = second;
    second = result;
      console.log(i + ": " + first + "\n");
  }

}
