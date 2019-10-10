##This program code can be used to check whether a string is a palindrome or not

string=str(input("Enter the string:"))
L=len(string)
for i in range(L,0,-1):
for j in range(L):
  if(string[i]==string[j]):
    print("Palindrome.")
  else:
    print("Not  Palindrome.")
  
  
