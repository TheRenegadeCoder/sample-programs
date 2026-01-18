import sys
from typing import NoReturn


def usage() -> NoReturn:
    print("Usage: please input a non-negative integer")
    sys.exit(1)


def fibonacci_up_to(n: int) -> list[int]:
    result: list[int] = []
    a = 1
    b = 2
    while a <= n:
        result.append(a)
        a, b = b, a + b

    return result


def zeckendorf(n: int) -> list[int]:
    result: list[int] = []
    fibs = fibonacci_up_to(n)
    idx = len(fibs) - 1
    while idx >= 0 and n > 0:
        fib = fibs[idx]
        if fib <= n:
            n -= fib
            result.append(fib)
            idx -= 2
        else:
            idx -= 1

    return result


def main() -> int:
    if len(sys.argv) < 2:
        usage()

    try:
        n = int(sys.argv[1])
    except ValueError:
        usage()

    if n < 0:
        usage()

    result = zeckendorf(n)
    print(result)


if __name__ == "__main__":
    main()
