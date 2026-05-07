module Enumerable
  def sorted?
    each_cons(2).all? { |a, b| (a <=> b) <= 0 }
  end
end

def parse_args
  list, key = ARGV
  raise ArgumentError unless list && key

  parts = list.split(",").map(&:strip)
  raise ArgumentError if parts.empty? || parts.any?(&:empty?)

  numbers = parts.map { Integer(it, exception: false) }
  raise ArgumentError if numbers.any?(nil)

  key = Integer(key, exception: false)
  raise ArgumentError if key.nil?

  raise ArgumentError unless numbers.sorted?

  [numbers, key]
end

begin
  numbers, key = parse_args
  puts !numbers.bsearch { key <=> it }.nil?
rescue ArgumentError
  warn 'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
end
