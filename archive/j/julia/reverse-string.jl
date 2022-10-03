#!/usr/bin/julia
# Reverse the Input String
# Function to print Error Message
function err()
  println("Usage: please provide a string")
end
# Function to reverse the input string
function reverse_string(n)
  if (length(n) in [0,1])
    err()
  else
    println(reverse(n))
  end
end

try
  reverse_string(ARGS[1])
catch e
  err()
end
