import sys


# This function returns value of each Roman symbol
def value(r):
    return {
        'I': 1,
        'V': 5,
        'X': 10,
        'L': 50,
        'C': 100,
        'D': 500,
        'M': 1000
    }[r]


def roman_to_decimal(string):
    res = 0
    i = 0

    while i < len(string):

        # Getting value of symbol s[i]
        s1 = value(string[i])

        if i+1 < len(string):

            # Getting value of symbol s[i+1]
            s2 = value(string[i + 1])

            # Comparing both values
            if s1 >= s2:

                # Value of current symbol is greater
                # or equal to the next symbol
                res += s1
                i += 1
            else:

                # Value of current symbol is less than
                # to the next symbol
                res = res + s2 - s1
                i += 2
        else:
            res += s1
            i += 1

    return res


def exit_with_error(msg):
    print(msg)
    sys.exit(1)


def main(args):
    if len(args) < 1:
        exit_with_error('Usage: please provide a string of roman numerals')

    try:
        roman_numeral = sys.argv[1]
        print(roman_to_decimal(roman_numeral))
    except KeyError:
        exit_with_error('Error: invalid string of roman numerals')


if __name__ == '__main__':
    main(sys.argv[1:])
