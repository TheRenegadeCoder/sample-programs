def max_sum(arr):
    lst = []
    
    for i in range(len(arr)):
        arr = arr[-1:]+arr[:-1]
        add=0
        print(arr)
        for i in range(len(arr)):
            print(i * arr[i])
            add += i * arr[i]
        lst.append(add)
        print("####")
    
    print("Maximum Sum is :"+str(max(lst)))
    



arr = [8,3,1,2]
max_sum(arr)


## print maximum sum of weighted rotated array of size 'n' after 'n' rotations.
## INPUT
## array : [8,3,1,2]
## weight distribution array (a[0]* 0,a[1]* 1,a[2]* 2,a[3]* 3,...,a[n]*n)
## array after 1st rotation ->[2, 8, 3, 1]
#                                            0
#                                            8
#                                            6
#                                            3
##-----------------------------------------------
## array after 2nd rotation ->[1, 2, 8, 3]
#                                            0
#                                            2
#                                            16
#                                            9
##------------------------------------------------
## array after 3rd rotation ->[3, 1, 2, 8]
#                                            0
#                                            1
#                                            4
#                                            24
##------------------------------------------------
## array after 4th rotation ->[8, 3, 1, 2]
#                                            0
#                                            3
#                                            2
#                                            6
##------------------------------------------------

# OUTPUT #
#~~~~~~~~~~~~~~~~~~~~~
# Maximum Sum is :29
#~~~~~~~~~~~~~~~~~~~~~
