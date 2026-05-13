# frozen_string_literal: true

USAGE = "Usage: please provide a string to encrypt"

def usage!
  warn USAGE
  exit 1
end

def rot13(str)
  str.tr("A-Za-z", "N-ZA-Mn-za-m")
end

input = ARGV.first
usage! if input.nil? || input.strip.empty?

puts rot13(input)
