for i [(range 1 101)] {
  if (== (% $i 15) 0) {
    echo FizzBuzz
  } elif (== (% $i 5) 0) {
    echo Buzz
  } elif (== (% $i 3) 0) {
    echo Fizz
  } else {
    echo $i
  }
}
