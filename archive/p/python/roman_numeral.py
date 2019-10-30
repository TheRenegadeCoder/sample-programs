# Python program to convert Roman Numerals
# to Numbers

import sys


# dictionary of roman numerals
_numerals = {'I': 1,
             'V': 5,
             'X': 10,
             'L': 50,
             'C': 100,
             'D': 500,
             'M': 1000
            }
_revNumerals = {v: k for k, v in _numerals.items()}


# This function returns value of each Roman symbol
def value(r):
    return _numerals[r]


def roman_to_decimal(string):
    res = 0
    i = 0

    while i < len(string):

        # Getting value of symbol s[i]
        s1 = value(string[i])

        if i + 1 < len(string):

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


def decimal_to_roman(n):
    """Takes a number, n, and converts it into minimum roman numeral form.
    Minimal Roman Numeral form indicates the length of the string is as small
    as possible.

    Contributed by @bizzfitch on github.

    Rules:
        1) Numerals must be arranged in descending order of size.
        2) M, C, and X cannot be equalled or exceeded by smaller denominations.
        3) D, L, and V can each only appear once.
        4) Only one I, X, and C can be used as the leading numeral in part
           of a subtractive pair: (IX as 9, XL as 40, etc.)
            a) I can only be placed before V and X.
            b) X can only be placed before L and C.
            c) C can only be placed before D and M.
    """
    if not isinstance(n, int) or n < 1:
        raise ValueError(f"{n} is not a positive integer.")
    s = ''
    while n > 0:
        if n in _revNumerals:
            s += _revNumerals[n]
            n = 0
        elif n > 1000:
            s += 'M'
            n -= 1000
            continue
        elif n >= 900:
            s += "CM"
            n -= 900
        elif n > 500:
            s += "D"
            n -= 500
        elif n >= 400:
            s += "CD"
            n -= 400
        elif n > 100:
            s += 'C'
            n -= 100
        elif n >= 90:
            s += 'XC'
            n -= 90
        elif n > 50:
            s += 'L'
            n -= 50
        elif n >= 40:
            s += 'XL'
            n -= 40
        elif n > 10:
            s += 'X'
            n -= 10
        elif n == 9:
            s += 'IX'
            n = 0
        elif n > 5:
            s += 'V'
            n -= 5
        elif n == 4:
            s += 'IV'
            n -= 4
        elif n < 4:
            s += 'I' * n
            n = 0
    return s


def exit_with_error(msg):
    print(msg)
    sys.exit(1)


def test_roman_numeral():
    """Pytyest function to ensure conversion.
    >>> test_roman_numeral()
    """
    for i in range(1, 10000):
        assert i == roman_to_decimal(decimal_to_roman(i))


def main(args):
    if len(args) < 1:
        exit_with_error("Usage: please provide a string of roman numerals or " 
                        "a positive integer to convert.")

    try:
        roman_numeral = sys.argv[1]
        try:
            R = int(roman_numeral)
            print(decimal_to_roman(R))
        except ValueError:
            print(roman_to_decimal(roman_numeral))
    except KeyError:
        exit_with_error('Error: invalid string of roman numerals')


if __name__ == '__main__':
    main(sys.argv[1:])
