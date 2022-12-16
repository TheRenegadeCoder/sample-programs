def josephus(n, k):
  if n == 1:
    return 1
  else:
    return (josephus(n - 1, k) + k-1) % n + 1

n = int(input('Enter the number of soldiers: '))
k = int(input('Enter the number of persons to skip: '))
print("Safe place: ", josephus(n, k))
