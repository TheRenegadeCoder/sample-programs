x = input('Enter a list of numbers separated by a comma\n')
x = x.split(',')
def sort(x):
    y  = []
    for i in x:
        y.append(int(i))
    y.sort()
    print (y)
sort(x)
