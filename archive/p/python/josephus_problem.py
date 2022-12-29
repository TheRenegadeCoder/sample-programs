import sys  # for receiving inputs from command line

def josephus(n, k): # main routine
  if (n == 1):
    return 1
  else:
    return (josephus(n - 1, k) + k-1) % n + 1

n, k = 0, 0  # initialising the values 

try:
  n = int(sys.argv[1])  # input from CLI
  k = int(sys.argv[2])  # input from CLI

except:
  print("Usage: please input the total number of people and number of people to skip.")
  exit(1)

if (n <= k):
    print("Usage: please input the total number of people and number of people to skip.")
    exit(1)

print(josephus(n, k))
