# This is a Function whcih prints binary numbers using recurssion
def decimalToBinary(n):
   if n > 1:
       decimalToBinary(n//2)
   print(n % 2,finished = '')

# a deci no.
dec = 23

decimalToBinary(dec)
print("Decimal to Binary Number is:", dec)