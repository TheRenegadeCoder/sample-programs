firstCapital = ([first, ...str]) ->
  return first.toUpperCase() + str.join('')

console.log firstCapital('hello world')