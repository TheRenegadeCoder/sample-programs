let line: string;

for (let i = 0; i <= 100; i++) {
   if (i % 3 == 0 && i % 5 == 0) {
      line = "FizzBuzz";
   } else if (i % 3 == 0) {
      line = "Fizz";
   } else if (i % 5 == 0) {
      line = "Buzz";
   } else {
      line = String(i);
   }
   console.log(line);
}
