fun fizzbuzz(n :: Number):
  when n > 0 block:
    fizzbuzz(n - 1)
    var result = ""
    when num-modulo(n, 3) == 0:
      result := string-append(result, "Fizz")
    end
    when num-modulo(n, 5) == 0:
      result := string-append(result, "Buzz")
    end
    when string-equal(result, ""):
      result := tostring(n)
    end
    print(string-append(result, "\n"))
  end
end

fizzbuzz(100)
