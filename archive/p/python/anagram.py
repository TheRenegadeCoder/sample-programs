#get two strings from the user
#The two strings are said to be a anagram if both contain the same alphabets

from collections import Counter
s1=tuple(input().strip())
s2=tuple(input().strip())
#Counter method takes in a tuple and returns a dictionary
s1_counter=Counter(s1)
s2_counter=Counter(s2)
#now  s1_counter and s2_counter are dictionaries
for keys in s1_counter:
    if s1_counter[keys]!=s2_counter[keys]:
        print("Not an Anagram")
        exit()
print("Anagram")        
#input:
# madam
# adamm
#output:
# Anagram