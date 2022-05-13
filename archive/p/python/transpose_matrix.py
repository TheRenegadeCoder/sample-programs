import sys

rows = int(sys.argv[1])
columns = int(sys.argv[2])
serial_matrix = [int(x) for x in sys.argv[3].split(',')]
print(serial_matrix)
