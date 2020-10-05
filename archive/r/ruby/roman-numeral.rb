ROMAN_VALUES = {
  "I": 1,
  "V": 5,
  "X": 10,
  "L": 50,
  "C": 100,
  "D": 500,
  "M": 1000
}

def roman_valid?(roman_numbers)
  return false if roman_numbers.any? { |roman_number| !ROMAN_VALUES.keys.include?(roman_number.to_sym) }  
  return false if roman_numbers.join.include?('MMMM')
  
  counter_numbers = roman_numbers.tally # Only on ruby 2.7+
  unless counter_numbers['M'].nil?
    return false if counter_numbers['M'] > 4
  end
  
  counter_numbers.reject { |k| k == 'M' }.all? { |(_, counter)| counter <= 3 }
end

def roman_to_decimal(full_roman_number)
  return 'Usage: please provide a string of roman numerals' if full_roman_number.nil?
  return 0 if full_roman_number.empty?

  roman_numbers = full_roman_number.upcase.split('')
  return 'Error: invalid string of roman numerals' unless roman_valid?(roman_numbers)

  previous = 0
  total = 0

  roman_numbers.each do |roman_number|
    value = ROMAN_VALUES[roman_number.to_sym]

    total += value if (value >= previous)
    total -= value unless (value >= previous)
    previous = value
  end

  total
end

p roman_to_decimal(ARGV[0])