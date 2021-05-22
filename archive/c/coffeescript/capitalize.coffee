firstCapital = ([first, ...str]) ->
  return first.toUpperCase() + str.join('')

console.log firstCapital prompt("Enter a string:")