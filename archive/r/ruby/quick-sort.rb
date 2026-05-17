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

def quicksort!(arr, lo = 0, hi = arr.length - 1)
  return arr if lo >= hi

  p = partition(arr, lo, hi)

  quicksort!(arr, lo, p - 1)
  quicksort!(arr, p + 1, hi)

  arr
end

def partition(arr, lo, hi)
  pivot = arr[hi]
  i = lo

  (lo...hi).each do |j|
    if arr[j] <= pivot
      arr[i], arr[j] = arr[j], arr[i]
      i += 1
    end
  end

  arr[i], arr[hi] = arr[hi], arr[i]
  i
end

numbers = parse_input
puts quicksort!(numbers).join(", ")
