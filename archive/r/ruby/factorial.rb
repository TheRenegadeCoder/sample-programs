value = ARGV[0].to_i

def check_empty(n)
  return n.to_s.empty?
end

def check_string(n)
  return n.is_a? String
end

def check_negative(n)
  return n.negative?
end

def fatorial(n)
  if check_string(n) == false && check_negative(n) == false && check_empty(n) == false
    if n == 1
      return n
    elsif n.zero?
      return 1
    else
      return n * fatorial(n - 1)
    end
  else
    return 'The number is a string or negative'
  end
end

result = fatorial(value)
puts "The fatorial of #{value} is #{result}"
