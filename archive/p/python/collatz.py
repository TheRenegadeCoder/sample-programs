import sys
from typing import List


def collatz(n: int) -> List[int]:
    """
    This function calculates the list of number generate by Collatz procedure.

    Consider the following operation on an arbitrary positive integer:
    If the number is even, divide it by two.
    If the number is odd, triple it and add one.
    The algorithm finishes when it arrives to 1.

    :param n: the integer number to start
    :return: the list with all middle values of the procedure
    """
    result = [n]
    while n != 1:
        if n % 2 == 0:
            n = n // 2
        else:
            n = 3 * n + 1
        result.append(n)
    return result


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: please provide an int')
    else:
        print(collatz(int(sys.argv[1])))
