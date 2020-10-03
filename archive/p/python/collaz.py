import sys
from typing import List


def collaz(n: int) -> List[int]:
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
        print(collaz(int(sys.argv[1])))
