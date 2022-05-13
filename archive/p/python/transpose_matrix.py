import sys

if len(sys.argv) != 4 or any(not x for x in sys.argv[1:]):
    print("Usage: please enter the dimension of the matrix and the serialized matrix")
    sys.exit(1)
    
columns = int(sys.argv[1])
rows = int(sys.argv[2])
serial_matrix = [int(x) for x in sys.argv[3].split(',')]
matrix = [[serial_matrix[i * columns + j] for j in range(columns)] for i in range(rows)]
transposed_matrix = [[matrix[j][i] for j in range(rows)] for i in range(columns)]
serial_transposed_matrix = [x for row in transposed_matrix for x in row]
print(serial_transposed_matrix)
