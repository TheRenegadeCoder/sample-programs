#!/usr/bin/env python
import sys


def factorial(n):
    if n <= 0:
        return 1
    return n * factorial (n - 1)


def exit_with_error(msg=None):
    msg = msg or 'Usage: plase input a non-negative integer'
    print(msg)
    sys.exit(1)


def main(args):
    try:
        n = int(args[0])
        if n < 0:
            exit_with_error()
        elif n >= 996:
            exit_with_error('{}! is out of the reasonable bounds for calculation'.format(n))
        print(factorial(n))
    except (IndexError, ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

