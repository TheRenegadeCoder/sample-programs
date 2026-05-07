def expand(s, l, r)
  while l >= 0 && r < s.length && s[l] == s[r]
    l -= 1
    r += 1
  end

  [l + 1, r - l - 1] # start, length
end

def longest_palindromic_substring(s)
  return if s.to_s.empty?

  best_start = 0
  best_len = 1

  s.length.times do |i|
    start1, len1 = expand(s, i, i)
    start2, len2 = expand(s, i, i + 1)

    start, len = (len1 > len2) ? [start1, len1] : [start2, len2]

    if len > best_len
      best_start, best_len = start, len
    end
  end

  s.slice(best_start, best_len)
end

input = ARGV.first
result = longest_palindromic_substring(input)

abort("Usage: please provide a string that contains at least one palindrome") if result.nil? || result.length <= 1

puts result
