for n in range(1, 101):
    s = ""
    s += "Fizz" if n % 3 == 0
    s += "Buzz" if n % 5 == 0
    s += "$(n)" if not s
    print s
