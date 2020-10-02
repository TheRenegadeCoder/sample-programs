"""
    Author : Nameer Waqas
    Date   : 02/10/2020
    Title  : Two way linear search algorithm.
    Time Complexity : O(n/2)
    Test Case : arr = [1,2,3,4,5] , valToSearch = -1 
"""

def twoWayLinear(arr=[],valToSearch=-1):
    j= len(arr) -1
    for i in range(len(arr)//2 +1):
        if arr[i] == valToSearch : return True
        if arr[j] == valToSearch : return True
        j-=1
    return False

# Function call    
twoWayLinear([1,2,3,4,5],3) # False

