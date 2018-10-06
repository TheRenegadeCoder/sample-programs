import sys

def fibonacci(n):
  first = 0
  second = 1
  result = 0
  for i in range(1, int(n)+1):
    result = first + second
    first = second
    second = result
    print(i, ": ", first)

fibonacci(sys.argv[1])
