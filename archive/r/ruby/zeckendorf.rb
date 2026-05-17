# frozen_string_literal: true

USAGE = "Usage: please input a non-negative integer"

def usage!
  warn USAGE
  exit 1
end

def parse_input(str)
  usage! if str.nil? || str.strip.empty?

  n = Integer(str)
  usage! if n < 0

  n
rescue ArgumentError, NoMethodError
  usage!
end

def fibs_upto(n)
  fibs = [1, 2]
  fibs << fibs[-1] + fibs[-2] while fibs[-1] <= n
  fibs.pop if fibs[-1] > n
  fibs
end

def zeckendorf(n)
  return [] if n == 0

  fibs = fibs_upto(n)
  result = []

  i = fibs.length - 1

  while n > 0
    if fibs[i] <= n
      result << fibs[i]
      n -= fibs[i]
      i -= 2
    else
      i -= 1
    end
  end

  result
end

input = ARGV.first
n = parse_input(input)

puts zeckendorf(n).join(", ")
