#!/usr/bin/julia
# Reverse the Input String
# Function to reverse the input string
function reverse_string(n)
  println(reverse(n))
end

if (length(ARGS) > 0)
  reverse_string(ARGS[1])
end
