import operator
import sys
from fractions import Fraction

d = {
    "+": operator.add,
    "-": operator.sub,
    "*": operator.mul,
    "/": operator.truediv,
    "==": lambda x, y: int(operator.eq(x, y)),
    "<": lambda x, y: int(operator.lt(x, y)),
    ">": lambda x, y: int(operator.gt(x, y)),
    "<=": lambda x, y: int(operator.le(x, y)),
    ">=": lambda x, y: int(operator.ge(x, y)),
    "!=": lambda x, y: int(operator.ne(x, y)),
}


def main(args):
    if len(args) != 3:
        print("Usage: ./fraction-math operand1 operator operand2")
        sys.exit(1)
    else:
        try:
            o1 = Fraction(args[0])
        except ValueError:
            print(f"Invalid operand: {args[0]}")
        try:
            o2 = Fraction(args[2])
        except ValueError:
            print(f"Invalid operand: {args[2]}")
        try:
            print(d[args[1]](o1, o2))
        except KeyError:
            print(f"Invalid operator: {args[1]}")


if __name__ == "__main__":
    main(sys.argv[1:])
