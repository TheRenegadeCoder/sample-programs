#!/usr/bin/julia
# Remove four types of characters: spaces (" "), tabs ("\t"), newlines ("\n"), and carriage returns ("\r").
function err()
  println("Usage: please provide a string")
end

function remove_all_whitespaces(n)
  println("length of", n, length(n))
  if (length(n) in [0,1])
    err()
  else
    compliments = Dict(" " => "", "\t" => "", "\n" => "", "\r" => "")
    println(join([compliments[c] for c in n]))
  end
end

try
  remove_all_whitespaces(parse(ARGS[1]))
catch e
  err()
end
