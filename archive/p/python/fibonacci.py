import sys


def fibonacci(n):
    fib = fibs()
    for i in range(1, n + 1):
        print(f'{i}: {next(fib)}')


def fibs():
    first = 1
    second = 1
    yield first
    yield second
    while True:
        new = first + second
        yield new
        first = second
        second = new


def main(args):
    try:
        fibonacci(int(args[0]))
    except (IndexError, ValueError):
        print("Usage: please input the count of fibonacci numbers to output")
        sys.exit(1)


if __name__ == "__main__":
    main(sys.argv[1:])
