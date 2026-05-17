# frozen_string_literal: true

USAGE = 'Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")'

def usage!
  warn USAGE
  exit 1
end

def parse_list(str)
  str.split(",").map { Integer(it.strip) }
rescue ArgumentError, NoMethodError
  usage!
end

def matrix(flat)
  n = Integer(Math.sqrt(flat.size))
  usage! unless n * n == flat.size
  flat.each_slice(n).to_a
end

def dfs(mat, vals, i, target, seen)
  return true if vals[i] == target
  return false if seen[i]

  seen[i] = true

  mat[i].each_with_index do |edge, j|
    next unless edge == 1
    return true if dfs(mat, vals, j, target, seen)
  end

  false
end

tree_s, vals_s, target_s = ARGV
usage! if tree_s.nil? || vals_s.nil? || target_s.nil?

tree = parse_list(tree_s)
vals = parse_list(vals_s)
target = begin
  Integer(target_s)
rescue
  usage!
end

usage! unless vals.size * vals.size == tree.size

mat = matrix(tree)

puts dfs(mat, vals, 0, target, {})
