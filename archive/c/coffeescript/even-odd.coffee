USAGE = "Usage: please input a number"
main = (arg) ->
  numberParsed = parseInt(arg)
  isNumber = Number.isInteger(numberParsed)
  if isNumber
    if numberParsed % 2 == 0 then "Even" else "Odd"
  else
    USAGE

console.log main(process.argv[2])