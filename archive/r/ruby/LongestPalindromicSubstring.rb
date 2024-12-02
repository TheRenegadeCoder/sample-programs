def longest_palindromic_substring(s)
  return "Usage: please provide a string that contains at least one palindrome" if s.nil? || s.empty?

  longest = ""

  # Loop through each character in the string
  (0...s.length).each do |i|
    # Check for the longest odd-length palindrome centered at `i`
    odd_palindrome = expand_from_center(s, i, i)
    # Check for the longest even-length palindrome centered between `i` and `i+1`
    even_palindrome = expand_from_center(s, i, i + 1)

    # Update longest if we found a longer palindrome
    longest = [longest, odd_palindrome, even_palindrome].max_by(&:length)
  end

  longest
end

# Helper function to expand from the center and find a palindrome
def expand_from_center(s, left, right)
  # Expand outwards while the characters are the same
  while left >= 0 && right < s.length && s[left] == s[right]
    left -= 1
    right += 1
  end
  # Return the substring that is a palindrome
  s[(left + 1)...right]
end

# Example usage
puts longest_palindromic_substring("paapaapap")
