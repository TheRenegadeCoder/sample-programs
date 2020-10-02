# Sample Input - 86
# Sample Output - "80 + 6"

def expand(num):
    length = len(str(num))
    result = ''
    num = str(num)
    for i in range(length):
        if num[i] != '0':
            ans = int(num[i]) * (10**(length-i-1))
            result += str(ans) + ' + '
        
    return result[:-3]
        
        
num = int(input())
print(expand(num))
