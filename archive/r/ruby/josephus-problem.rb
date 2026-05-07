def josephus(n, k)
  (1..n).reduce(0) { |acc, i| (acc + k) % i } + 1
end

def usage!
  abort("Usage: please input the total number of people and number of people to skip.")
end

n, k = ARGV

usage! unless n && k
usage! unless n.match?(/\A\d+\z/) && k.match?(/\A\d+\z/)

n = n.to_i
k = k.to_i

puts josephus(n, k)
