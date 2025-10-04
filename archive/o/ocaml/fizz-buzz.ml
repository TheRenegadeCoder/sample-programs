let fizzbuzz i =
  if i mod 15 == 0
  then "FizzBuzz"
  else if i mod 5 == 0
  then "Buzz"
  else if i mod 3 == 0
  then "Fizz"
  else string_of_int i
;;

for i = 1 to 100 do
  print_string (fizzbuzz(i) ^ "\n")
done;;
