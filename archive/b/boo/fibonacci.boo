def fib():
    a, b = 0L, 1L       # The 'L's make the numbers double word length (typically 64 bits)
    while true:
        yield b
        a, b = b, a + b

# Print the first 5 numbers in the series:
for index as int, element in zip(range(5), fib()):
    print("${index+1}: ${element}")
