string = str(input("Enter the string:"))
L = len(string)
for i in range(L, 0, -1):
    for j in range(L):
        if string[i] == string[j]:
            print("Palindrome.")
        else:
            print("Not  Palindrome.")
