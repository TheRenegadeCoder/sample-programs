# frozen_string_literal: true

class Array
  def insertion_sort!
    (1...length).each do |i|
      value = self[i]
      j = i - 1

      while j >= 0 && self[j] > value
        self[j + 1] = self[j]
        j -= 1
      end

      self[j + 1] = value
    end

    self
  end
end

def usage!
  abort %(Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5")
end

def parse_input
  raw = ARGV.first
  usage! if raw.nil? || raw.strip.empty?

  numbers = raw.split(",").map { Integer(it.strip) }
  usage! if numbers.length < 2

  numbers
rescue ArgumentError
  usage!
end

puts parse_input.insertion_sort!.join(", ")
