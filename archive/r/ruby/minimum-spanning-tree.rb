# frozen_string_literal: true

USAGE = "Usage: please provide a comma-separated list of integers"

def usage!
  warn USAGE
  exit 1
end

def parse_input
  raw = ARGV.first
  usage! if raw.nil? || raw.strip.empty?

  nums = raw.split(",").map { Integer(it.strip) }
  n = Integer(Math.sqrt(nums.length))
  usage! unless n * n == nums.length

  Array.new(n) { |i| nums[i * n, n] }
rescue ArgumentError, NoMethodError
  usage!
end

def find(parent, x)
  (parent[x] == x) ? x : (parent[x] = find(parent, parent[x]))
end

def union(parent, rank, a, b)
  a = find(parent, a)
  b = find(parent, b)
  return if a == b

  if rank[a] < rank[b]
    parent[a] = b
  elsif rank[a] > rank[b]
    parent[b] = a
  else
    parent[b] = a
    rank[a] += 1
  end
end

def mst_weight(matrix)
  n = matrix.size

  edges =
    (0...n).flat_map do |i|
      (i + 1...n).map do |j|
        w = matrix[i][j]
        w.positive? ? [w, i, j] : nil
      end
    end.compact

  edges.sort_by!(&:first)

  parent = (0...n).to_a
  rank = Array.new(n, 0)

  edges.reduce(0) do |total, (w, u, v)|
    next total if find(parent, u) == find(parent, v)

    union(parent, rank, u, v)
    total + w
  end
end

matrix = parse_input
puts mst_weight(matrix)
