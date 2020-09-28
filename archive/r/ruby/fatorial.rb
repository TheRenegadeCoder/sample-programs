value = ARGV[0].to_i

def fatorial(v)
  if v == 1
    return v
  else
    return v*fatorial(v - 1)
  end
end

result = fatorial(value)
puts "The fatorial of #{value} is #{result}"
