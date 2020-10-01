print("Pattern Matching")
num = int(input("Enter a Number"))
print("Enter True or False")
val = input()

if val == "True":
    for i in range(1,num+1):           # 'num+1' to prevent printing ONE LESS row..
        print("*"*i)

if val == "False":
    for i in range(num,0,-1):          # 'num' to '0' to print the given number of rows.
        print("*"*i)