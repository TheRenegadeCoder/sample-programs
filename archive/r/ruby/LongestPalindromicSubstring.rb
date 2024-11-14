def longest_palindromic_substring(s)
    return "Usage: please provide a string that contains at least one palindrome" if s.nil? || s.empty?
  
    longest = ""
  
    # Loop through each character in the string
    (0...s.length).each do |i|
      # Check for the longest odd-length palindrome centered at `i`
      odd_palindrome = expand_from_center(s, i, i)
      # Check for the longest even-length palindrome centered between `i` and `i+1`
      even_palindrome = expand_from_center(s, i, i + 1)
  
     