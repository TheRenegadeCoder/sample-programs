for n in range(1, 101):
    if n % 3 == 0:
        print("FizzBuzz" if n % 5 == 0 else "Fizz")
        continue
    print("Buzz" if n % 5 == 0 else n)
