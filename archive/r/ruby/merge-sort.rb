# frozen_string_literal: true

def usage!
  abort %(Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5")
end

def parse_input
  raw = ARGV.first
  usage! if raw.nil? || raw.strip.empty?

  numbers = raw.split(",").map { Integer(it.strip) }
  usage! if numbers.length < 2

  numbers
rescue ArgumentError, NoMethodError
  usage!
end

def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..])

  merge(left, right)
end

def merge(left, right)
  i = 0
  j = 0
  result = []

  while i < left.length && j < right.length
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

  result.concat(left[i..] || [])
  result.concat(right[j..] || [])
  result
end

numbers = parse_input
puts merge_sort(numbers).join(", ")
