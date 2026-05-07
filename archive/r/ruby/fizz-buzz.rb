def fizzbuzz(n)
  result = +""

  result << "Fizz" if n % 3 == 0
  result << "Buzz" if n % 5 == 0

  puts(result.empty? ? n : result)
end

(1..100).each { fizzbuzz(it) }
