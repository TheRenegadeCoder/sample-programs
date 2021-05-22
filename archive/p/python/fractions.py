import operator
import sys
from fractions import Fraction

d = {
    "+": operator.add,
    "-": operator.sub,
    "*": operator.mul,
    "/": operator.truediv,
    "==": operator.eq,
    "<": operator.lt,
    ">": operator.gt,
    "<=": operator.le,
    ">=": operator.ge,
    "!=": operator.ne,
}


def main(args):
    if len(args) != 3:
        print("Usage: python fraction.py operand1 operator operand2")
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
