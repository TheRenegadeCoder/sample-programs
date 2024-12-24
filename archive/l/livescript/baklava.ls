for n from -10 to 10
  num_spaces = Math.abs(n)
  num_stars = 21 - 2 * num_spaces
  console.log ' '.repeat(num_spaces) + '*'.repeat(num_stars)
