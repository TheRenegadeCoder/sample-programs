#!/usr/bin/julia
# Capitalize first character of the input string
# Function to print Error message
function err()
  println("Usage: please provide a string")
end
# Function to capitalize the input string
function capitalize(n)
  if (length(n) in [0,1])
    err()
  else
    println(uppercasefirst(n))
  end
end

try
  capitalize(ARGS[1])
catch e
  err()
end
