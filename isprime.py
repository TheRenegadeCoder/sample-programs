#program to check if a number is prime.

n=int(input('enter the number'))
count=0
for i in range(1,n):
    if n%(i)==0:
     print(i,',')
     count+=1
if count==1:
    print('it is prime')
else:
    print('it isnt prime')
