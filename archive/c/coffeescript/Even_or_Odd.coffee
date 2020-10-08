even_or_odd = (number) ->
  if number.length == 0
    return 'please input a number'
  if number % 2 == 0
    'Even'
  else if number % 2 == 1 or number % 2 == -1
    'Odd'
  else
    'please input a number'

number = prompt('Enter a number: ')
console.log even_or_odd(number)
