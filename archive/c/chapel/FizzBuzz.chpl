for i in 1..100 do
  if (i % 15 == 0) {
    writeln("FizzBuzz");
  } else if (i % 5 == 0) {
    writeln("Buzz");
  } else if (i % 3 == 0) {
    writeln("Fizz");
  } else {
    writeln(i);
  }
