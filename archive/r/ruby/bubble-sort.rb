class Array
  def bubble_sort
    arr = dup
    n = arr.length

    (n - 1).times do |i|
      swapped = false

      (n - i - 1).times do |j|
        next unless arr[j] > arr[j + 1]

        arr[j], arr[j + 1] = arr[j + 1], arr[j]
        swapped = true
      end

      break unless swapped
    end

    arr
  end
end

def parse_input
  raw = ARGV.first
  raise ArgumentError unless raw

  numbers = raw.split(",").map { Integer(it.strip, exception: false) }
  raise ArgumentError if numbers.any?(nil) || numbers.length < 2

  numbers
end

def usage!
  abort %(Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5")
end

begin
  numbers = parse_input
  puts numbers.bubble_sort.join(", ")
rescue ArgumentError
  usage!
end
