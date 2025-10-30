for i from 1 to 100
    word = ''
    word += 'Fizz' if i % 3 is 0
    word += 'Buzz' if i % 5 is 0
    console.log(word or i)