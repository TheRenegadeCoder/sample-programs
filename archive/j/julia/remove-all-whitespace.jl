using Core: print
function err()
  println("Usage: please provide a string")
end

function remove_all_whitespaces(n)
  if (length(n) in [0,1])
    err()
  else
    n_nospace = (filter(x -> !isspace(x), n))
    n_notab = replace(n_nospace,  "\t" => "")
    n_nonewline = replace(n_notab,  "\n" => "")
    n_nonewline = replace(n_notab,  "\r" => "")
    println(n_nonewline)
  end
end

try
  # remove_all_whitespaces(parse(ARGS[1]))
  remove_all_whitespaces(ARGS[1])
catch e
  err()
end
