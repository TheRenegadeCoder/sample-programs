# frozen_string_literal: true

USAGE = 'Usage: please provide a list of integers (e.g. "8, 3, 1, 2")'

def usage!
  warn USAGE
  exit 1
end

def parse_list(str)
  str.split(",").map { Integer(it.strip) }
rescue ArgumentError, NoMethodError
  usage!
end

def max_rotation_sum(arr)
  n = arr.size
  total_sum = arr.sum
  current = arr.each_with_index.sum { |v, i| i * v }

  max = current

  (1...n).each do |i|
    last = arr[n - i]
    current += total_sum - n * last
    max = current if current > max
  end

  max
end

raw = ARGV.first
usage! if raw.nil? || raw.strip.empty?

arr = parse_list(raw)

puts max_rotation_sum(arr)
