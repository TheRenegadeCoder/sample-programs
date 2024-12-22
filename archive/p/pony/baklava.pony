actor Main
  new create(env: Env) =>
    var n: I32 = -10
    while n <= 10 do
      let numSpaces: I32 = if n >= 0 then n else -n end
      let numStars: I32 = 21 - (2 * numSpaces)
      env.out.print(repeatString(" ", numSpaces) + repeatString("*", numStars))
      n = n + 1
    end

  fun repeatString(s: String, n: I32): String =>
    var result = ""
    var i: I32 = 0
    while i < n do
      result = result + s
      i = i + 1
    end
    result
