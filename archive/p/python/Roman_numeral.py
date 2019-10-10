# File: Roman_to_decimal_number_system.py
# Description: Conversion Roman number to decimal number system
# Environment: PyCharm and Anaconda environment
# Implementing the task
# Converting Roman number system to decimal number system
# By using regular expressions

# Importing library 're'
import re

# Creating a pattern for finding following numbers in the string: 4, 9, 40, 90, 400, 900
# By using '|' we say which groups of symbols to look for
pattern_1 = r'IV|IX|XL|XC|CD|CM'

# Inputting string in Roman number system
string = input()  # 'MCMLXXXIV'

# Finding all inclusions according to the pattern_1 and put them into the list
all_inclusions = re.findall(pattern_1, string)  # ['CM', 'IV']

# Deleting found inclusions in the string
for i in range(len(all_inclusions)):
    string = re.sub(all_inclusions[i], r'', string)  # At the end we'll receive 'MLXXX'

# Creating a pattern for finding following numbers in the string: 1, 5, 10, 50, 100, 500, 1000
# By using '|' we say which groups of symbols to look for
pattern_2 = r'I|V|X|L|C|D|M'

# Finding all inclusions according to the pattern_2 and adding them to the list
all_inclusions += re.findall(pattern_2, string)  # We'll receive ['CM', 'IV', 'M', 'L', 'X', 'X', 'X']

# Creating a dictionary for conversion
d = {'I': 1,
     'V': 5,
     'X': 10,
     'L': 50,
     'C': 100,
     'D': 500,
     'M': 1000,
     'IV': 4,
     'IX': 9,
     'XL': 40,
     'XC': 90,
     'CD': 400,
     'CM': 900}

# Converting to decimal number system
# Going through all elements of the list and finding the values in the dictionary
# After the appropriate values were found it is needed just to add them all together
n = 0
for x in all_inclusions:
    n += d[x]

print(n)
