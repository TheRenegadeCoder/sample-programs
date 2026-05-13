# frozen_string_literal: true

USAGE = 'Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"'

def usage!
  warn USAGE
  exit 1
end

def parse_list(str)
  str.split(",").map { Integer(it.strip) }
rescue ArgumentError, NoMethodError
  usage!
end

def max_subarray_sum(arr)
  return arr.first if arr.length == 1
  return arr.sum if arr.none?(&:negative?)

  current = max = arr.first

  arr[1..].each do |x|
    current = [x, current + x].max
    max = [max, current].max
  end

  max
end

raw = ARGV.first
usage! if raw.nil? || raw.strip.empty?

arr = parse_list(raw)
usage! if arr.length < 1

puts max_subarray_sum(arr)
