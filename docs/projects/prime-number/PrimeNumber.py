# Prime number in Python
# Author : Sanjay Siddha Pradeep Kumar
# Created Date: 11 October, 2019
# Last updated: 11 October, 2019


def checkPrimeOrNot(num):
    # If given number is greater than 1 
    if num > 1: 
        
        # Iterate from 2 to n / 2  
        for i in range(2, num//2): 
                
            # If num is divisible by any number between  
            # 2 and n / 2, it is not prime  
            if (num % i) == 0: 
                # print(num, "is not a prime number") 
                printComposite()
                break
            else: 
                # print(num, "is a prime number")
                printPrime()
                break 
    else: 
        printComposite()

def checkForPostiveOrNegativeInteger(givenUserInput):

    try:
        if int(givenUserInput) > 0 :
            return True     
        else:
            return False
    except Error as e:
        if e == ValueError:
            printErrorMessage()

def printErrorMessage():
    print("Usage: please input a non-negative integer")

def printComposite():
    print("Composite")

def printPrime():
    print("Prime")

def checkIntegerOrNot(userValue):
    try:
        if (type(int(userValue)) == int):
            return True
        else:
            return False
    except ValueError:
        printErrorMessage()
        exit()
if __name__ == '__main__':

    userInput = input("Enter a number to check whether it's prime or not! :" )
    if(len(userInput) == 0):
        printErrorMessage()
        exit()
    if not checkIntegerOrNot(userInput):
        printErrorMessage()
        exit()
    if not checkForPostiveOrNegativeInteger(userInput):
        printErrorMessage()
        exit()
    checkPrimeOrNot(int(userInput))
    







