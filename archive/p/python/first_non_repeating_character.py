#First Non-Repeating Character
def fnrc(arr):

    #A copy of the given array
    temp = list(arr)

    #A hash map to save the items and the number of times they appear
    map = {i:0 for i in temp}

    #Adds one to each element in the hash every time they appear in the list
    for x in temp:
        map[x]+=1

    #Iterates over the list and compares to the hash to see if some item appeared only one time
    for x in temp:
        if map[x]==1: return x

    #If not
    return False



print(fnrc(["a",1,2,1,2,"a",3,2,3,4,3,5,6,4,6]))
#Output: 5
