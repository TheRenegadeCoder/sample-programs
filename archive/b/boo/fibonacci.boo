import System

def usage():
    print("Usage: please input the count of fibonacci numbers to output")
    Environment.Exit(0)

def fib(n):
    a, b = 0L, 1L       # The 'L's make the numbers double word length (typically 64 bits)
    for index in range(n):
        yield index + 1, b
        a, b = b, a + b

# Print the first n numbers in the series:
try:
    n = int.Parse(argv[0])
    for index as int, element in fib(n):
        print("${index}: ${element}")
except _ as IndexOutOfRangeException:
    usage()
except _ as FormatException:
    usage()
