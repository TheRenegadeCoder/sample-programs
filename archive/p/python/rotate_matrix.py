#This code will rotate any given n x n 2D matrix by 90 degrees (clockwise)
A = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
m = len(A)
n = int(m/2)
for i in range(n):
    for j in range(i, m-1-i):
        temp = A[i][j]
        A[i][j] = A[m-1-j][i]
        A[m-1-j][i] = A[m-1-i][m-1-j]
        A[m-1-i][m-1-j] = A[j][m-1-i]
        A[j][m-1-i] = temp
print(A)
#output
#[[13, 9, 5, 1], [14, 10, 6, 2], [15, 11, 7, 3], [16, 12, 8, 4]]
