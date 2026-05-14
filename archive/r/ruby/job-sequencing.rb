# frozen_string_literal: true

USAGE = "Usage: please provide a list of profits and a list of deadlines"

def usage!
  warn USAGE
  exit 1
end

def parse_list(str)
  str.split(",").map { Integer(it.strip) }
rescue ArgumentError, NoMethodError
  usage!
end

def find(parent, x)
  while parent[x] != x
    parent[x] = parent[parent[x]]
    x = parent[x]
  end
  x
end

def schedule(profits, deadlines)
  jobs = profits.zip(deadlines)
  max_d = deadlines.max

  parent = (0..max_d).to_a

  total = 0

  jobs.sort_by { -it[0] }.each do |profit, d|
    slot = find(parent, [d, max_d].min)

    next if slot == 0

    parent[slot] = slot - 1
    total += profit
  end

  total
end

profits_str, deadlines_str = ARGV
usage! if profits_str.nil? || deadlines_str.nil? ||
  profits_str.strip.empty? || deadlines_str.strip.empty?

profits = parse_list(profits_str)
deadlines = parse_list(deadlines_str)

usage! if profits.size != deadlines.size

puts schedule(profits, deadlines)
