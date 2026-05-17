# frozen_string_literal: true

USAGE = "Usage: please enter the dimension of the matrix and the serialized matrix"

def usage!
  warn USAGE
  exit 1
end

def parse_int(str)
  Integer(str)
rescue ArgumentError, NoMethodError
  usage!
end

def parse_list(str)
  str.split(",").map { parse_int(it.strip) }
end

cols_str, rows_str, matrix_str = ARGV

usage! if cols_str.nil? || rows_str.nil? || matrix_str.nil?
usage! if cols_str.strip.empty? || rows_str.strip.empty? || matrix_str.strip.empty?

cols = parse_int(cols_str)
rows = parse_int(rows_str)

usage! if cols <= 0 || rows <= 0

flat = parse_list(matrix_str)
usage! if flat.length != cols * rows

matrix = flat.each_slice(cols).to_a
transposed = matrix.transpose

puts transposed.flatten.join(", ")
