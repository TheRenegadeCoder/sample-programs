"""
    Author : Nameer Waqas
    Date   : 02/10/2020
    Title  : Pattern of Left triangle
"""

def printLeftTriangle(limit):
    whiteSpaces = limit
    print("**********HacktoberFest 2020**********")
    for i in range(limit):
        for j in range(whiteSpaces):
            print(" ",end="")
        whiteSpaces-=1
        for k in range(i+1):
            print("*",end="")
        print('',end="\n")

# Function Call        
printLeftTriangle(5)


