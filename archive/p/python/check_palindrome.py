# program to check palindrome in python


while True:
    x = input('input text : ')

    w = ""
    for i in x:
        w = i + w

    if (x == w):
        print("Yes its palindrom")
    else:
        print("No its not palindrom") 