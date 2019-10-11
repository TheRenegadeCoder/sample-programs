from math import floor
def ndiamond(n):
    a = 1
    i = 1
    k = 1
    j = floor(n/2)
    while i < n:
        print((j-1)*" ",end = " ")
        print(a*a)
        i = i + 2
        a = a*10 + 1
        j = j -1 
    print(a*a)
    c = floor(a/10)
    while i > 1:
        print((k-1)*" ",end = " ")
        print(c*c)
        c = floor(c/10)
        i = i - 2
        k = k + 1     
