def parse_input(str)
  return if str.to_s.strip.empty?

  nums = str.split(",").map { Integer(it.strip, exception: false) }
  return if nums.any?(nil?) || nums.length < 2

  nums
end

class Array
  def selection_sort
    arr = dup
    sorted = []

    until arr.empty?
      min_index = arr.each_index.min_by { |i| arr[i] }
      sorted << arr.delete_at(min_index)
    end

    sorted
  end
end

USAGE = 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'

input = parse_input(ARGV.first)
abort(USAGE) unless input

puts input.selection_sort.join(", ")
