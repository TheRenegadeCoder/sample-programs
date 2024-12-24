string_repeat = (s, n) ->
  result = ""
  for i = 1, n
    result ..= s
  return result

for i = -10, 10
  num_spaces = math.abs i
  num_stars = 21 - 2 * num_spaces
  print string_repeat(" ", num_spaces) .. string_repeat("*", num_stars)
