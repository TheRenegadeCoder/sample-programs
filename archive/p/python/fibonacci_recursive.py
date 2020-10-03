# In mathematics, Fibonacci numbers are the numbers that make up the following
# succession of integers.
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144,…

# In mathematical terms, the sequence is defined recursively by the formula below:
#        { 0,
# F(n) = { 1,
#        { F(n-1) + F(n-2)


def fibonacci(amount, sequence=(0, 1)):
    return sequence if len(sequence) == amount else \
        fibonacci(amount, sequence + (sum(sequence[-2:]),))


if __name__ == '__main__':

    n = int(input('n = '))

    for fib in fibonacci(n):
        print(fib)
