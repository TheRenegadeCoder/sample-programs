import sys


def fibonacci_rec(n):
    if n < 0:
        raise ValueError
    elif n == 0:
        return 0
    elif n == 1 or n == 2:
        return 1
    else:
        return fibonacci_rec(n - 1) + fibonacci_rec(n - 2)


def main(args):
    try:
        print(fibonacci_rec(int(args[0])))
    except (IndexError, ValueError):
        print("Please enter an index: ")
        sys.exit(1)


if __name__ == "__main__":
    main(sys.argv[1:])
