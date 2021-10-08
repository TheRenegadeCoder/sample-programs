#taking string as input
s = input()

#declaring an empty dictionary to keep track of elements occuring moree than once
d = {}

#traversing through the string
for i in s:
    
    #checking if the string character is there in dictionary or not and updating its occurence value
    if i in d.keys():
        d[i] += 1
        continue
    else:
        #storing only those elements in the dictionary which occur more than once
        if s.count(i) > 1:
            d[i] = 1

#checking the length if dictionary is empty or not
if len(d) == 0:
    print("No duplicate characters")
else:
    for i in d.keys():
        print("Characters: ",i," Occurences: ", d[i])

        
