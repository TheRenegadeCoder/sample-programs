import random

a = random.randint(5,20)
ls = []
for i in range(a):
    ls.append(random.randint(100,1000))
    print(ls[i],end=" ")
print("\nMaximum in the list is ",max(ls))