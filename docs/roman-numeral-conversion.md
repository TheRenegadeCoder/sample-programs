# Roman Numeral Conversion

Roman numerals are the numbers that were used in ancient Rome, which employed
combinations of letters from the Latin alphabet (I, V, X, L, C, D and M).

The following table shows the letter to decimal mapping:

| Letter | Decimal |
| ------ | ------- |
| I      | 1       |
| V      | 5       |
| X      | 10      |
| L      | 50      |
| C      | 100     |
| D      | 500     |
| M      | 1000    |

Stringing together these digits yield a value that is the sum of their
respective mappings. However, there is a catch. Roman numerals must appears in
order of greatest to least. If a smaller value appears before a larger one,
the smaller value is subtracted from the total.

As a result, a string like `XV` would evaluate to 15 while `XIV` would
evaluate to 14.

Of course, there are other limitations, but we'll ignore those for simplicity.

## Requirements

Using the table above, write a sample program which accepts a Roman numeral on
the command line and outputs its decimal value on standard output. Store the
solution in a file called Roman Numeral Conversion using whatever naming
convention is appropriate for the choice language.

*Please* make sure your program is executable. In other words, the solution
should be able to be called in the appropriate environment with a string
of roman numerals (i.e. `./roman-numeral-conversion XXVI`).
