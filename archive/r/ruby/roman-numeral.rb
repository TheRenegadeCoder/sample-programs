ROMAN = {
  "I" => 1, "V" => 5, "X" => 10, "L" => 50,
  "C" => 100, "D" => 500, "M" => 1000
}.freeze

USAGE = "Usage: please provide a string of roman numerals"
ERROR = "Error: invalid string of roman numerals"

def valid_roman?(s)
  return false unless s.match?(/\A[IVXLCDM]+\z/)

  # no more than 3 repeats
  return false if s.match?(/(.)\1{3,}/)

  # invalid repeatables
  %w[V L D].each { |ch| return false if s.include?(ch * 2) }

  true
end

def roman_to_int(s)
  return USAGE if s.nil?

  s = s.upcase
  return 0 if s.empty?
  return ERROR unless valid_roman?(s)

  total = 0

  s.chars.each_cons(2) do |a, b|
    total += (ROMAN[a] < ROMAN[b]) ? -ROMAN[a] : ROMAN[a]
  end

  total + ROMAN[s[-1]]
end

puts roman_to_int(ARGV.first)
